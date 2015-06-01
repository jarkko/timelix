defmodule Timelix.TimerControllerTest do
  use Timelix.ConnCase

  alias Timelix.Timer
  @valid_attrs %{start_time: 42}
  @invalid_attrs %{}

  setup do
    conn = conn()
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, timer_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing timers"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, timer_path(conn, :new)
    assert html_response(conn, 200) =~ "New timer"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, timer_path(conn, :create), timer: @valid_attrs
    assert redirected_to(conn) == timer_path(conn, :index)
    assert Repo.get_by(Timer, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, timer_path(conn, :create), timer: @invalid_attrs
    assert html_response(conn, 200) =~ "New timer"
  end

  test "shows chosen resource", %{conn: conn} do
    timer = Repo.insert %Timer{}
    conn = get conn, timer_path(conn, :show, timer)
    assert html_response(conn, 200) =~ "Show timer"
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    timer = Repo.insert %Timer{}
    conn = get conn, timer_path(conn, :edit, timer)
    assert html_response(conn, 200) =~ "Edit timer"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    timer = Repo.insert %Timer{}
    conn = put conn, timer_path(conn, :update, timer), timer: @valid_attrs
    assert redirected_to(conn) == timer_path(conn, :index)
    assert Repo.get_by(Timer, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    timer = Repo.insert %Timer{}
    conn = put conn, timer_path(conn, :update, timer), timer: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit timer"
  end

  test "deletes chosen resource", %{conn: conn} do
    timer = Repo.insert %Timer{}
    conn = delete conn, timer_path(conn, :delete, timer)
    assert redirected_to(conn) == timer_path(conn, :index)
    refute Repo.get(Timer, timer.id)
  end
end
