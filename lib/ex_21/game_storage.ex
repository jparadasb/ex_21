defmodule Ex21.GameStorage do
  alias Ex21.GamePlay

  def setup do
    :ets.new(:game_state_table, [:set, :public, :named_table])
  end

  def fetch_game(game_id) do
    case :ets.lookup(:game_state_table, game_id) do
      [] ->
        game = GamePlay.start()
        :ets.insert(:game_state_table, {game_id, game})
        game

      [{^game_id, game}] ->
        game
    end
  end

  def save_game(game_id, game), do: :ets.insert(:game_state_table, {game_id, game})

  def delete_game(game_id), do: :ets.delete(:game_state_table, game_id)
end
