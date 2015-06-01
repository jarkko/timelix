defmodule Timelix.ResultTest do
  use Timelix.ModelCase

  alias Timelix.Result

  @valid_attrs %{bib_number: 42, result: 42, runner_id: 42, timer_id: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Result.changeset(%Result{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Result.changeset(%Result{}, @invalid_attrs)
    refute changeset.valid?
  end
end
