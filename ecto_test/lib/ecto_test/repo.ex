defmodule EctoTest.Repo do
  use Ecto.Repo, adapter: Ecto.Adapters.Postgres

  def conf do
    parse_url "ecto://elixir:elixir@localhost/ecto_test"
  end

  def priv do
    app_dir(:ecto_test, "priv/repo")
  end
end
