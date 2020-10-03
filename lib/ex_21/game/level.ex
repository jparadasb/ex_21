defmodule Ex21.Game.Level do
  def next_level(level \\ 0) do
    level_range(level + 1)
  end

  defp level_range(level) do
    case level do
      l when l in 1..10 -> %{level: l, cards: 10 + (l * 6)}
      l when l in 11..20 -> %{level: l, cards: 10 + (l * 8)}
      _ -> %{level: level, cards: 10 + (level * 10)}
    end
  end
end
