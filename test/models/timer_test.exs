defmodule Timelix.TimerTest do
  use Timelix.ModelCase

  alias Timelix.Timer

  @valid_attrs %{start_time: 42}
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
