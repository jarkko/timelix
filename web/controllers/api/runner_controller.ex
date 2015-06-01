defmodule Timelix.Api.RunnerController do
  use Timelix.Web, :controller

  alias Timelix.Runner

  plug :scrub_params, "runner" when action in [:create, :update]
  plug :action

  def index(conn, _params) do
    runners = Repo.all(Runner)
    render(conn, "index.json", runners: runners)
  end

  def create(conn, %{"runner" => runner_params}) do
    changeset = Runner.changeset(%Runner{}, runner_params)

    if changeset.valid? do
      runner = Repo.insert(changeset)
      render(conn, "show.json", runner: runner)
    else
      conn
      |> put_status(:unprocessable_entity)
      |> render(Timelix.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    runner = Repo.get(Runner, id)
    render conn, "show.json", runner: runner
  end

  def update(conn, %{"id" => id, "runner" => runner_params}) do
    runner = Repo.get(Runner, id)
    changeset = Runner.changeset(runner, runner_params)

    if changeset.valid? do
      runner = Repo.update(changeset)
      render(conn, "show.json", runner: runner)
    else
      conn
      |> put_status(:unprocessable_entity)
      |> render(Timelix.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    runner = Repo.get(Runner, id)

    runner = Repo.delete(runner)
    render(conn, "show.json", runner: runner)
  end
end
