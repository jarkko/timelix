defmodule Timelix.Result do
  use Timelix.Web, :model

  schema "results" do
    field :runner_id, :integer
    field :result, :integer
    field :timer_id, :integer
    field :bib_number, :integer

    timestamps
  end

  @required_fields ~w(runner_id result timer_id bib_number)
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
