defmodule Ex21.Game.LevelTest do
  use ExUnit.Case, async: true

  alias Ex21.Game.Level

  describe "Next level incremental" do
    test "next_level/1 level 0" do
      assert %{level: 1, cards: 16} = Level.next_level()
    end

    test "next_level/1 level 1 to 10" do
      [
        %{level: 1, cards: 16},
        %{level: 2, cards: 22},
        %{level: 3, cards: 28},
        %{level: 4, cards: 34},
        %{level: 5, cards: 40},
        %{level: 6, cards: 46},
        %{level: 7, cards: 52},
        %{level: 8, cards: 58},
        %{level: 9, cards: 64},
        %{level: 10, cards: 70}
      ]
      |> Enum.each(fn(ls) ->
        assert ls == Level.next_level(ls.level - 1)
      end)
    end

    test "next_level/1 level 11 to 20" do
      [
        %{level: 11, cards: 98},
        %{level: 12, cards: 106},
        %{level: 13, cards: 114},
        %{level: 14, cards: 122},
        %{level: 15, cards: 130},
        %{level: 16, cards: 138},
        %{level: 17, cards: 146},
        %{level: 18, cards: 154},
        %{level: 19, cards: 162},
        %{level: 20, cards: 170}
      ]
      |> Enum.each(fn(ls) ->
        assert ls == Level.next_level(ls.level - 1)
      end)
    end

    test "next_level/1 level 21 to 100" do
      [
        %{level: 30, cards: 310},
        %{level: 40, cards: 410},
        %{level: 50, cards: 510},
        %{level: 60, cards: 610},
        %{level: 70, cards: 710},
        %{level: 80, cards: 810},
        %{level: 90, cards: 910},
        %{level: 100, cards: 1010}
      ]
      |> Enum.each(fn(ls) ->
        assert ls == Level.next_level(ls.level - 1)
      end)
    end
  end
end
