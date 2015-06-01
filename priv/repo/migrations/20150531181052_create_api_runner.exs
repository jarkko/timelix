defmodule Timelix.Repo.Migrations.CreateApi.Runner do
  use Ecto.Migration

  def change do
    create table(:api/runners) do

      timestamps
    end

  end
end
