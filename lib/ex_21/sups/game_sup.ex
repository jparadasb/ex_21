defmodule Ex21.Sups.GameSup do
  use DynamicSupervisor
  require Logger

  def start_link(_args) do
    Logger.info("Starting #{__MODULE__} supervisor")
    DynamicSupervisor.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def init(_) do
    DynamicSupervisor.init(strategy: :one_for_one)
  end

  def start_game(game_id) do
    child_spec = %{
      id: Ex21.Server.PlayerGame,
      start: {Ex21.Server.PlayerGame, :start_link, [game_id]},
      restart: :transient
    }

    DynamicSupervisor.start_child(__MODULE__, child_spec)
  end

  def child_spec(opts) do
    %{
      id: __MODULE__,
      start: {__MODULE__, :start_link, [opts]},
      type: :supervisor,
      restart: :permanent,
      shutdown: 20000
    }
  end
end
