defmodule TcpServer.Server do
  def listen(port) do
    tcp_options = [:binary, {:packet, 0}, {:active, false}]
    {:ok, listening_socket} = :gen_tcp.listen(port, tcp_options)
    IO.puts "listening on port #{port}"

    do_accept(listening_socket)
  end

  def do_accept(listening_socket) do
    {:ok, socket} = :gen_tcp.accept(listening_socket)
    do_listen(socket)
  end

  def do_listen(socket) do
    case :gen_tcp.recv(socket, 0) do
      {:ok, data} ->
        IO.puts "Got some data! #{data}"
        :gen_tcp.send(socket, "Roger, wilco!\n")
        do_listen(socket)

      {:error, closed} ->
        IO.puts "The client closed the connection..."
    end
  end
end
