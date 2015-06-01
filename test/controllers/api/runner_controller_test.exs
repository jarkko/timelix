defmodule Timelix.Api.RunnerControllerTest do
  use Timelix.ConnCase

  alias Timelix.Runner
  @valid_attrs %{}
  @invalid_attrs %{}

  setup do
    conn = conn() |> put_req_header("accept", "application/json")
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, runner_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    runner = Repo.insert %Runner{}
    conn = get conn, runner_path(conn, :show, runner)
    assert json_response(conn, 200)["data"] == %{
      "id" => runner.id
    }
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, runner_path(conn, :create), runner: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Runner, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, runner_path(conn, :create), runner: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    runner = Repo.insert %Runner{}
    conn = put conn, runner_path(conn, :update, runner), runner: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Runner, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    runner = Repo.insert %Runner{}
    conn = put conn, runner_path(conn, :update, runner), runner: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    runner = Repo.insert %Runner{}
    conn = delete conn, runner_path(conn, :delete, runner)
    assert json_response(conn, 200)["data"]["id"]
    refute Repo.get(Runner, runner.id)
  end
end
