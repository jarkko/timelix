defmodule Timelix.Repo.Migrations.CreateResult do
  use Ecto.Migration

  def change do
    create table(:results) do

      timestamps
    end

  end
end
