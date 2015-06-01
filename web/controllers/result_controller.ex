defmodule Timelix.ResultController do
  use Timelix.Web, :controller

  alias Timelix.Result

  plug :scrub_params, "result" when action in [:create, :update]
  plug :action

  def index(conn, _params) do
    results = Repo.all(Result)
    render(conn, "index.html", results: results)
  end

  def new(conn, _params) do
    changeset = Result.changeset(%Result{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"result" => result_params}) do
    changeset = Result.changeset(%Result{}, result_params)

    if changeset.valid? do
      Repo.insert(changeset)

      conn
      |> put_flash(:info, "Result created successfully.")
      |> redirect(to: result_path(conn, :index))
    else
      render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    result = Repo.get(Result, id)
    render(conn, "show.html", result: result)
  end

  def edit(conn, %{"id" => id}) do
    result = Repo.get(Result, id)
    changeset = Result.changeset(result)
    render(conn, "edit.html", result: result, changeset: changeset)
  end

  def update(conn, %{"id" => id, "result" => result_params}) do
    result = Repo.get(Result, id)
    changeset = Result.changeset(result, result_params)

    if changeset.valid? do
      Repo.update(changeset)

      conn
      |> put_flash(:info, "Result updated successfully.")
      |> redirect(to: result_path(conn, :index))
    else
      render(conn, "edit.html", result: result, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    result = Repo.get(Result, id)
    Repo.delete(result)

    conn
    |> put_flash(:info, "Result deleted successfully.")
    |> redirect(to: result_path(conn, :index))
  end
end
