defmodule Ex21.Game.EventManager do

  def subscribe_game(game_id) do
    Phoenix.PubSub.subscribe(ShipitEx.PubSub, game_id, link: true)
  end

  def notify_next_level(game_id) do
    Phoenix.PubSub.broadcast(
      Ex21.PubSub,
      game_id,
      :next_level
    )
  end

  def notify_lost_game(game_id) do
    Phoenix.PubSub.broadcast(
      Ex21.PubSub,
      game_id,
      :lost_game
    )
  end
end
