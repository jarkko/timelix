defmodule Timelix.RunnerTest do
  use Timelix.ModelCase

  alias Timelix.Runner

  @valid_attrs %{bib_number: 42, category_id: 42, first_name: "some content", last_name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Runner.changeset(%Runner{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Runner.changeset(%Runner{}, @invalid_attrs)
    refute changeset.valid?
  end
end
