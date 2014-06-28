defmodule Schizo do
  use Application.Behaviour

  # See http://elixir-lang.org/docs/stable/Application.Behaviour.html
  # for more information on OTP Applications
  def start(_type, _args) do
    Schizo.Supervisor.start_link
  end

  def uppercase(string) do
    transform_every_other_word(string, &uppercaser/1)
  end

  def unvowel(string) do
    transform_every_other_word(string, &unvoweler/1)
  end

  def transform_every_other_word(string, transformation) do
    # split string on spaces
    words = String.split(string)
    # Transform every other word (uppercase)
    words_with_index = Stream.with_index(words)
    transformed_words = Enum.map(words_with_index, transformation)
    # join
    Enum.join(transformed_words, " ")
  end

  def uppercaser(input) do
    transformer(input, &String.upcase/1)
  end

  def unvoweler(input) do
    transformer(input, fn (word) -> Regex.replace(~r([aeiou]), word, "") end)
  end

  def transformer({word, index}, transformation) do
    cond do
      rem(index, 2) == 0 -> word
      rem(index, 2) == 1 -> transformation.(word)
    end
  end
end
