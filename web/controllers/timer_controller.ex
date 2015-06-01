defmodule Timelix.TimerController do
  use Timelix.Web, :controller

  alias Timelix.Timer

  plug :scrub_params, "timer" when action in [:create, :update]
  plug :action

  def index(conn, _params) do
    timers = Repo.all(Timer)
    render(conn, "index.html", timers: timers)
  end

  def new(conn, _params) do
    changeset = Timer.changeset(%Timer{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"timer" => timer_params}) do
    changeset = Timer.changeset(%Timer{}, timer_params)

    if changeset.valid? do
      Repo.insert(changeset)

      conn
      |> put_flash(:info, "Timer created successfully.")
      |> redirect(to: timer_path(conn, :index))
    else
      render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    timer = Repo.get(Timer, id)
    render(conn, "show.html", timer: timer)
  end

  def edit(conn, %{"id" => id}) do
    timer = Repo.get(Timer, id)
    changeset = Timer.changeset(timer)
    render(conn, "edit.html", timer: timer, changeset: changeset)
  end

  def update(conn, %{"id" => id, "timer" => timer_params}) do
    timer = Repo.get(Timer, id)
    changeset = Timer.changeset(timer, timer_params)

    if changeset.valid? do
      Repo.update(changeset)

      conn
      |> put_flash(:info, "Timer updated successfully.")
      |> redirect(to: timer_path(conn, :index))
    else
      render(conn, "edit.html", timer: timer, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    timer = Repo.get(Timer, id)
    Repo.delete(timer)

    conn
    |> put_flash(:info, "Timer deleted successfully.")
    |> redirect(to: timer_path(conn, :index))
  end
end
