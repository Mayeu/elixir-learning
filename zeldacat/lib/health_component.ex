defmodule HealthComponent do
  use GenEvent.Behaviour

  ### Public API
  def get_hp(entity) do
    :gen_event.call(entity, HealthComponent, :get_hp)
  end

  def alive?(entity) do
    :gen_event.call(entity, HealthComponent, :alive?)
  end

  ### GenEvent API
  def init(hp) do
    {:ok, hp}
  end

  def handle_call(:get_hp, hp) do
    {:ok, hp, hp}
  end

  def handle_call(:alive?, hp) do
    {:ok, hp > 0, hp}
  end

  def handle_event({:hit, amount}, hp) do
    {:ok, hp - amount}
  end

  def handle_event({:heal, amount}, hp) do
    {:ok, hp + amount}
  end
end
