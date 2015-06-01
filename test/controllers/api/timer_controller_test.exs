defmodule Timelix.Api.TimerControllerTest do
  use Timelix.ConnCase

  alias Timelix.Api.Timer
  @valid_attrs %{}
  @invalid_attrs %{}

  setup do
    conn = conn() |> put_req_header("accept", "application/json")
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, timer_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    timer = Repo.insert %Timer{}
    conn = get conn, timer_path(conn, :show, timer)
    assert json_response(conn, 200)["data"] == %{
      "id" => timer.id
    }
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, timer_path(conn, :create), timer: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Timer, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, timer_path(conn, :create), timer: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    timer = Repo.insert %Timer{}
    conn = put conn, timer_path(conn, :update, timer), timer: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Timer, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    timer = Repo.insert %Timer{}
    conn = put conn, timer_path(conn, :update, timer), timer: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    timer = Repo.insert %Timer{}
    conn = delete conn, timer_path(conn, :delete, timer)
    assert json_response(conn, 200)["data"]["id"]
    refute Repo.get(Timer, timer.id)
  end
end
