defmodule Ex21.Server.PlayerGame do
  use GenServer
  alias Ex21.{GamePlay, GameStorage}
  alias Ex21.Game.EventManager


  @timeout :timer.hours(1)

  def start_link(game_id) do
    GenServer.start_link(__MODULE__, [game_id], name: via_tuple(game_id))
  end

  def via_tuple(game_id), do: {:via, Registry, {:game_registry, game_id}}

  def init(game_id) do
    state = GameStorage.fetch_game(game_id)

    {:ok, state, @timeout}
  end

  ## ------------------##
  ##    Client API     ##
  ## ------------------##

  def pid(game_id) do
    via_tuple(game_id)
    |> GenServer.whereis()
  end

  def start(game_id) do
    GenServer.call(via_tuple(game_id), :start)
  end

  def terminate(game_id) do
    GenServer.call(via_tuple(game_id), :shutdown)
  end

  def summary(game_id) do
    GenServer.call(via_tuple(game_id), :summary)
  end

  def sum(game_id, value) do
    GenServer.cast(via_tuple(game_id), {:sum, value})
  end

  def add_on_hold(game_id) do
    GenServer.cast(via_tuple(game_id), {:add_on_hold})
  end

  def set_on_hold(game_id, value) do
    GenServer.cast(via_tuple(game_id), {:set_on_hold, value})
  end

  ## ------------------##
  ##    Server API     ##
  ## ------------------##

  def handle_call(:start, _from, state) do
    GameStorage.save_game(game_id_from_registry(), state)
    {:reply, :ok, state, @timeout}
  end

  def handle_call(:summary, _from, state) do
    {:reply, state, state, @timeout}
  end

  def handle_call(:shutdown, _from, state) do
    {:stop, :normal, :ok, state}
  end

  def handle_cast({:sum, value}, state) do
    new_state = GamePlay.sum(state, value)
    send(self(), :check_threshold)
    send(self(), :check_cards)
    {:noreply, new_state, @timeout}
  end

  def handle_cast({:add_on_hold}, state) do
    new_state = GamePlay.add_on_hold(state)
    send(self(), :check_threshold)
    send(self(), :check_cards)
    {:noreply, new_state, @timeout}
  end

  def handle_cast({:set_on_hold, value}, state) do
    new_state = GamePlay.set_on_hold(state, value)
    {:noreply, new_state, @timeout}
  end

  def terminate(:normal, _state) do
    game_id_from_registry() |> GameStorage.delete_game()
    :ok
  end

  def terminate({:shutdown, :timeout}, _state) do
    game_id_from_registry() |> GameStorage.delete_game()
    :ok
  end

  def terminate(_reason, _state) do
    game_id_from_registry() |> GameStorage.delete_game()
    :ok
  end

  def handle_info(:check_threshold, state) do
    if GamePlay.outside_threshold(state) do
      game_id_from_registry() |>
      EventManager.notify_lost_game()
    end
    {:noreply, state, @timeout}
  end

  def handle_info(:check_cards, state) do
    if state.cards == 0 do
      new_state = GamePlay.next_level(state.level)
      game_id_from_registry() |>
      EventManager.notify_next_level()
      {:noreply, new_state, @timeout}
    else
      {:noreply, state, @timeout}
    end
  end

  defp game_id_from_registry do
    Registry.keys(:game_registry, self()) |> List.first()
  end
end
