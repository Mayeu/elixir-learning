defmodule SchizoTest do
  use ExUnit.Case

  test "uppercase doesn't change the first word" do
    assert(Schizo.uppercase("foo") == "foo")
  end

  test "uppercase converts the second word to uppercase" do
    assert(Schizo.uppercase("foo bar") == "foo BAR")
  end

  test "uppercase converts every other word to uppercase" do
    assert(Schizo.uppercase("foo bar baz whee") == "foo BAR baz WHEE")
  end

  test "unvowel doesn't change the first word" do
    assert(Schizo.unvowel("foo") == "foo")
  end

  test "unvowel remove the second word vowels" do
    assert(Schizo.unvowel("foo bar") == "foo br")
  end

  test "unvowel removes every other word to vowels" do
    assert(Schizo.unvowel("foo bar baz whee") == "foo br baz wh")
  end
end
