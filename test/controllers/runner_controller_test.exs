defmodule Timelix.RunnerControllerTest do
  use Timelix.ConnCase

  alias Timelix.Runner
  @valid_attrs %{bib_number: 42, category_id: 42, first_name: "some content", last_name: "some content"}
  @invalid_attrs %{}

  setup do
    conn = conn()
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, runner_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing runners"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, runner_path(conn, :new)
    assert html_response(conn, 200) =~ "New runner"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, runner_path(conn, :create), runner: @valid_attrs
    assert redirected_to(conn) == runner_path(conn, :index)
    assert Repo.get_by(Runner, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, runner_path(conn, :create), runner: @invalid_attrs
    assert html_response(conn, 200) =~ "New runner"
  end

  test "shows chosen resource", %{conn: conn} do
    runner = Repo.insert %Runner{}
    conn = get conn, runner_path(conn, :show, runner)
    assert html_response(conn, 200) =~ "Show runner"
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    runner = Repo.insert %Runner{}
    conn = get conn, runner_path(conn, :edit, runner)
    assert html_response(conn, 200) =~ "Edit runner"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    runner = Repo.insert %Runner{}
    conn = put conn, runner_path(conn, :update, runner), runner: @valid_attrs
    assert redirected_to(conn) == runner_path(conn, :index)
    assert Repo.get_by(Runner, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    runner = Repo.insert %Runner{}
    conn = put conn, runner_path(conn, :update, runner), runner: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit runner"
  end

  test "deletes chosen resource", %{conn: conn} do
    runner = Repo.insert %Runner{}
    conn = delete conn, runner_path(conn, :delete, runner)
    assert redirected_to(conn) == runner_path(conn, :index)
    refute Repo.get(Runner, runner.id)
  end
end
