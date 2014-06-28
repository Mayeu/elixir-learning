defmodule CountActor do
  use ExActor.GenServer, export: :counter

  defcall get, state: state, when: state == 2, do: reply(:two)
  defcall get, state: state, do: reply(state)

  defcast inc, state: state, do: new_state(state + 1)
  defcast dec, state: state, do: new_state(state - 1)
end
