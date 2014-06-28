defmodule Unix do
  def ps_ax do
    """
  PID TTY      STAT   TIME COMMAND
16829 pts/3    S+     0:00 vim test/pipe_operator_playground_test.exs
16874 pts/3    S+     0:00 /bin/bash -c (ps ax | tail -n 6) >/tmp/v0vNthy/3 2>&1
16875 pts/3    S+     0:00 /bin/bash -c (ps ax | tail -n 6) >/tmp/v0vNthy/3 2>&1
16876 pts/3    R+     0:00 ps ax
16877 pts/3    S+     0:00 tail -n 6
    """
  end

  def grep(input, match) do
    String.split(input, "\n")
      |> Enum.filter(fn(line) -> Regex.match?(match, line) end)
  end

  def awk(lines, column) do
    Enum.map(lines, fn(line) ->
      stripped = String.strip(line)
        |> Unix.regex_split(~r/ /)
        |> Enum.at(column-1)
    end)
  end

  def regex_split(input, regex) do
    Regex.split(regex, input, trim: true)
  end
end

defmodule PipeOperatorPlaygroundTest do
  use ExUnit.Case

  test "ps_ax output some processes" do
    output = """
  PID TTY      STAT   TIME COMMAND
16829 pts/3    S+     0:00 vim test/pipe_operator_playground_test.exs
16874 pts/3    S+     0:00 /bin/bash -c (ps ax | tail -n 6) >/tmp/v0vNthy/3 2>&1
16875 pts/3    S+     0:00 /bin/bash -c (ps ax | tail -n 6) >/tmp/v0vNthy/3 2>&1
16876 pts/3    R+     0:00 ps ax
16877 pts/3    S+     0:00 tail -n 6
    """

    assert Unix.ps_ax == output
  end

  test "grep(lines, thing) returns lines that math 'thing'" do
    lines = """
    foo
    bar
    thing foo
    baz
    thing qux
    """

    output = ["thing foo", "thing qux"]
    assert Unix.grep(lines, ~r/thing/) == output
  end

  test "awk(input, 1) splits on whitespace and return the first column" do
    input = ["foo bar", "baz   qux"]
    output = ["foo", "baz"]
    assert Unix.awk(input, 1) == output
  end

  test "the whole pipeline works" do
    assert(Unix.ps_ax |> Unix.grep(~r/vim/) |> Unix.awk(1)) == ["16829"]
  end
end
