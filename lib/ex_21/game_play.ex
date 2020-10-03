defmodule Ex21.GamePlay do
  alias Ex21.Game.Level

  @min 0
  @max 21

  def start do
    Level.next_level()
    |> Map.merge(%{accum: Enum.random(1..10), on_hold: nil})
  end

  def sum(game_state = %{accum: accum, cards: cards}, value) do
    %{game_state | accum: accum + value, cards: cards - 1}
  end

  def set_on_hold(game_state = %{cards: cards}, value) do
    %{game_state | on_hold: value, cards: cards - 1}
  end

  def add_on_hold(game_state = %{on_hold: on_hold, accum: accum}) do
    %{game_state | accum: accum + on_hold, on_hold: nil}
  end

  def outside_threshold(%{accum: accum}) do
    @max <= accum || @min >= accum
  end
end
