defmodule Timelix.RunnerController do
  use Timelix.Web, :controller

  alias Timelix.Runner

  plug :scrub_params, "runner" when action in [:create, :update]
  plug :action

  def index(conn, _params) do
    runners = Repo.all(Runner)
    render(conn, "index.html", runners: runners)
  end

  def new(conn, _params) do
    changeset = Runner.changeset(%Runner{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"runner" => runner_params}) do
    changeset = Runner.changeset(%Runner{}, runner_params)

    if changeset.valid? do
      Repo.insert(changeset)

      conn
      |> put_flash(:info, "Runner created successfully.")
      |> redirect(to: runner_path(conn, :index))
    else
      render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    runner = Repo.get(Runner, id)
    render(conn, "show.html", runner: runner)
  end

  def edit(conn, %{"id" => id}) do
    runner = Repo.get(Runner, id)
    changeset = Runner.changeset(runner)
    render(conn, "edit.html", runner: runner, changeset: changeset)
  end

  def update(conn, %{"id" => id, "runner" => runner_params}) do
    runner = Repo.get(Runner, id)
    changeset = Runner.changeset(runner, runner_params)

    if changeset.valid? do
      Repo.update(changeset)

      conn
      |> put_flash(:info, "Runner updated successfully.")
      |> redirect(to: runner_path(conn, :index))
    else
      render(conn, "edit.html", runner: runner, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    runner = Repo.get(Runner, id)
    Repo.delete(runner)

    conn
    |> put_flash(:info, "Runner deleted successfully.")
    |> redirect(to: runner_path(conn, :index))
  end
end
