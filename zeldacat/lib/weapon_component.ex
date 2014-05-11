defmodule WeaponComponent do
  use GenEvent.Behaviour

  ### Public API
  def list_weapons(entity) do
    :gen_event.call(entity, WeaponComponent, :list_weapons)
  end

  ### GenEvent API
  def init(weapons) do
    {:ok, weapons}
  end

  def handle_event({:add_weapon, weapon}, weapons) do
    {:ok, weapons ++ [weapon]}
  end

  def handle_call(:list_weapons, weapons) do
    {:ok, weapons, weapons}
  end
end
