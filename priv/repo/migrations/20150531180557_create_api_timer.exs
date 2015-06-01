defmodule Timelix.Repo.Migrations.CreateApi.Timer do
  use Ecto.Migration

  def change do
    create table(:api/timers) do

      timestamps
    end

  end
end
