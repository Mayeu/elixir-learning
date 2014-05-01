Dynamo.under_test(Dwitter.Dynamo)
Dynamo.Loader.enable
ExUnit.start

defmodule Dwitter.TestCase do
  use ExUnit.CaseTemplate

  # Enable code reloading on test cases
  setup do
    Dynamo.Loader.enable
    :ok
  end
end
