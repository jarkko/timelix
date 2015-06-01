defmodule Timelix.Timer do
  use Timelix.Web, :model

  schema "timers" do
    field :start_time, :integer

    timestamps
  end

  @required_fields ~w(start_time)
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
