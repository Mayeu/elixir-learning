defmodule KVServer do
  use Application

  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      supervisor(Task.Supervisor, [[name: KVServer.TaskSupervisor]]),
      worker(Task, [KVServer, :accept, [4040]])
    ]

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: KVServer.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def accept(port) do
    # The options below mean:
    #
    # 1. `:binary` - receives data as binaries (instead of lists)
    # 2. `packet: :line` - receives data by line by line
    # 3. `active: false` - block on `:gen_tcp.recv/2` until data is available
    #
    {:ok, socket} = :gen_tcp.listen(port, [:binary, packet: :line, active: false])
    IO.puts "Accepting connections on part #{port}"
    loop_acceptor(socket)
  end

  defp loop_acceptor(socket) do
    {:ok, client} = :gen_tcp.accept(socket)
    Task.Supervisor.start_child(KVServer.TaskSupervisor, fn -> serve(client) end)
    loop_acceptor(socket)
  end

  defp serve(socket) do
    import Pipe

    msg =
      pipe_matching x, {:ok, x},
        read_line(socket)
        |> KVServer.Command.parse()
        |> KVServer.Command.run()

    write_line(socket, msg)
    serve(socket)
  end

  defp read_line(socket) do
    :gen_tcp.recv(socket, 0)
  end

  defp write_line(socket, msg) do
    :gen_tcp.send(socket, format_msg(msg))
  end

  defp format_msg({:ok, text}), do: text
  defp format_msg({:error, :unknown_command}), do: "UNKNOWN COMMAND\r\n"
  defp format_msg({:error, :not_found}), do: "NOT FOUND\r\n"
  defp format_msg({:error, _}), do: "ERROR\r\n"
end
