defmodule ListSupervisor do
  use Supervisor.Behaviour

  def start_link do
    :supervisor.start_link(__MODULE__, [])
  end

  def init(list) do
    child_processes = [worker(ListServer, list) ]
    supervise child_processes, strategy: :one_for_one
  end
end
