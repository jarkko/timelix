defmodule Timelix.Repo.Migrations.CreateTimer do
  use Ecto.Migration

  def change do
    create table(:timers) do
      add :start_time, :integer

      timestamps
    end

  end
end
