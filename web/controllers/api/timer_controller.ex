defmodule Timelix.Api.TimerController do
  use Timelix.Web, :controller

  alias Timelix.Timer

  plug :scrub_params, "timer" when action in [:create, :update]
  plug :action

  def index(conn, _params) do
    timers = Repo.all(Timer)
    render(conn, "index.json", timers: timers)
  end

  def create(conn, %{"timer" => timer_params}) do
    changeset = Timer.changeset(%Timer{}, timer_params)

    if changeset.valid? do
      timer = Repo.insert(changeset)
      render(conn, "show.json", timer: timer)
    else
      conn
      |> put_status(:unprocessable_entity)
      |> render(Timelix.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    timer = Repo.get(Timer, id)
    render conn, "show.json", timer: timer
  end

  def update(conn, %{"id" => id, "timer" => timer_params}) do
    timer = Repo.get(Timer, id)
    changeset = Timer.changeset(timer, timer_params)

    if changeset.valid? do
      timer = Repo.update(changeset)
      render(conn, "show.json", timer: timer)
    else
      conn
      |> put_status(:unprocessable_entity)
      |> render(Timelix.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    timer = Repo.get(Timer, id)

    timer = Repo.delete(timer)
    render(conn, "show.json", timer: timer)
  end
end
