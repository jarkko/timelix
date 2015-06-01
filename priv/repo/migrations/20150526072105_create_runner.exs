defmodule Timelix.Repo.Migrations.CreateRunner do
  use Ecto.Migration

  def change do
    create table(:runners) do
      add :first_name, :string
      add :last_name, :string
      add :bib_number, :integer
      add :category_id, :integer

      timestamps
    end

  end
end
