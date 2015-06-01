defmodule Timelix.Api.RunnerTest do
  use Timelix.ModelCase

  alias Timelix.Api.Runner

  @valid_attrs %{}
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
