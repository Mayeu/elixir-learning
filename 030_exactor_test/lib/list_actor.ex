defmodule ListActor do
  use ExActor.GenServer, initial_state: []

  defcall get, state: state, do: reply(state)

  defcast put(x), state: state, do: new_state(state ++ [x])
  defcast take(x), state: state, do: new_state(List.delete(state,x))
end
