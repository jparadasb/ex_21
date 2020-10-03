defmodule Ex21Web.GameLive do
  use Ex21Web, :live_view
  alias Ex21.GamePlay

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, game_play: nil)}
  end

  @impl true
  def handle_event("start_game", _, socket) do
    {:noreply, assign(socket, game_play: GamePlay.start())}
  end
end
