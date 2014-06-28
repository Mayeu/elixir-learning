Dynamo.under_test(Dwitter.Dynamo)
Dynamo.Loader.enable

defmodule Amnesia.Test do
  def start do
    :error_logger.tty(false)

    Amnesia.Schema.create
    Amnesia.start

    :ok
  end

  def stop do
    Amnesia.stop
    Amnesia.Schema.destroy

    :error_logger.tty(true)

    :ok
  end
end

ExUnit.start

defmodule Dwitter.TestCase do
  use ExUnit.CaseTemplate

  # Enable code reloading on test cases
  setup do
    Dynamo.Loader.enable
    :ok
  end
end
