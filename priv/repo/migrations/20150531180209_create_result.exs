defmodule Timelix.Repo.Migrations.CreateResult do
  use Ecto.Migration

  def change do
    create table(:api/results) do
      add :runner_id, :integer
      add :result, :integer
      add :timer_id, :integer
      add :bib_number, :integer

      timestamps
    end

  end
end
