defmodule ElixirCardDeck do
  def make_deck do
    values = [:a, 2, 3, 4, 5, 6, 7, 8, 9, 10, :j, :q, :k]
    suits = [:spades, :clubs, :diamonds, :hearts]
    for x <- values, y <- suits, do: {:card, x, y}
  end
end
