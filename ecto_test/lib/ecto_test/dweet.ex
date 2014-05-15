defmodule EctoTest.Dweet do
  use Ecto.Model

  queryable "dweets" do
    field :content, :string
    field :author,  :string
  end
end
