defmodule Timelix.Api.TimerTest do
  use Timelix.ModelCase

  alias Timelix.Api.Timer

  @valid_attrs %{}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Timer.changeset(%Timer{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Timer.changeset(%Timer{}, @invalid_attrs)
    refute changeset.valid?
  end
end
