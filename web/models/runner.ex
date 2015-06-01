defmodule Timelix.Runner do
  use Timelix.Web, :model

  schema "runners" do
    field :first_name, :string
    field :last_name, :string
    field :bib_number, :integer
    field :category_id, :integer

    timestamps
  end

  @required_fields ~w(first_name last_name bib_number category_id)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If `params` are nil, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
