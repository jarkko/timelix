defmodule Timelix.ResultControllerTest do
  use Timelix.ConnCase

  alias Timelix.Result
  @valid_attrs %{bib_number: 42, result: 42, runner_id: 42, timer_id: 42}
  @invalid_attrs %{}

  setup do
    conn = conn() |> put_req_header("accept", "application/json")
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, result_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    result = Repo.insert %Result{}
    conn = get conn, result_path(conn, :show, result)
    assert json_response(conn, 200)["data"] == %{
      "id" => result.id
    }
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, result_path(conn, :create), result: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Result, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, result_path(conn, :create), result: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    result = Repo.insert %Result{}
    conn = put conn, result_path(conn, :update, result), result: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Result, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    result = Repo.insert %Result{}
    conn = put conn, result_path(conn, :update, result), result: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    result = Repo.insert %Result{}
    conn = delete conn, result_path(conn, :delete, result)
    assert json_response(conn, 200)["data"]["id"]
    refute Repo.get(Result, result.id)
  end
end
