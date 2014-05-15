defmodule EctoTest.Repo.Migrations.CreateDweets do
  use Ecto.Migration

  def up do
    "CREATE TABLE dweets(id serial primary key, content varchar(140), author varchar(50))"
  end

  def down do
    "DROP TABLE dweets"
  end
end
