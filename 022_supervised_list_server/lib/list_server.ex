defmodule ListServer do
  use GenServer.Behaviour

  ### Public API
  def start_link do
    :gen_server.start_link({:local, :list}, __MODULE__, [], [])
  end

  def clear do
    :gen_server.cast :list, :clear
  end

  def add(item) do
    :gen_server.cast :list, {:add, item}
  end

  def remove(item) do
    :gen_server.cast :list, {:remove, item}
  end

  def items do
    :gen_server.call :list, :items
  end

  def crash do
    :gen_server.cast :list, :crash
  end

  ### GenServer API
  def init(list) do
    {:ok, list}
  end

  # Clear the list
  def handle_cast(:clear, list) do
    {:noreply, []}
  end

  def handle_cast({:add, item}, list) do
    {:noreply, list ++ [item]}
  end

  def handle_cast({:remove, item}, list) do
    {:noreply, List.delete(list, item)}
  end

  def handle_call(:items, _from, list) do
    {:reply, list, list}
  end

  def handle_cast(:crash, list) do
    1 = 2
  end
end
