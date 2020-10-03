defmodule Ex21.Game.Cards do
  def new_value do
    case Enum.random(-9..9) do
      0 -> new_value()
      value -> value
    end
  end
end
