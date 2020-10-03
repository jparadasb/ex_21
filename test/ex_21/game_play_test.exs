defmodule Ex21.GamePlayTest do
  use ExUnit.Case, async: true

  alias Ex21.GamePlay

  setup do
    {:ok, %{game_state: GamePlay.start}}
  end

  describe "GamePlay" do

    test "star/0" do
      new_game_state = GamePlay.start

      assert 1 == new_game_state.level
      assert nil == new_game_state.on_hold
      assert 16 == new_game_state.cards
      assert 11 > new_game_state.accum
      assert 0 < new_game_state.accum
    end

    test "sum/2", %{game_state: game_state} do
      value = 2
      accum = game_state.accum
      game_state = GamePlay.sum(game_state, value)
      assert value + accum == game_state.accum
      assert 15 == game_state.cards

      value = -3
      accum = game_state.accum
      game_state = GamePlay.sum(game_state, value)
      assert value + accum == game_state.accum
      assert 14 == game_state.cards
    end

    test "set_on_hold/2", %{game_state: game_state} do
      value = 9

      game_state = GamePlay.set_on_hold(game_state, value)
      assert !is_nil(game_state.on_hold)
      assert value == game_state.on_hold
      assert 15 == game_state.cards
    end

    test "add_on_hold/1", %{game_state: game_state} do
      game_state = %{game_state | on_hold: -1}
      accum = game_state.accum

      game_state = GamePlay.add_on_hold(game_state)
      assert is_nil(game_state.on_hold)
      assert accum + (-1) == game_state.accum
    end

    test "outside_threshold/1", %{game_state: game_state} do
      game_state = %{game_state | accum: 20}
      assert false == GamePlay.outside_threshold(game_state)
      game_state = GamePlay.sum(game_state, 1)
      assert true == GamePlay.outside_threshold(game_state)

      game_state = %{game_state | accum: 1}
      assert false == GamePlay.outside_threshold(game_state)
      game_state = GamePlay.sum(game_state, -1)
      assert true == GamePlay.outside_threshold(game_state)

      game_state = %{game_state | accum: 30}
      assert true == GamePlay.outside_threshold(game_state)

      game_state = %{game_state | accum: -10}
      assert true == GamePlay.outside_threshold(game_state)
    end
  end
end
