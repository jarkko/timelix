defmodule Timelix.Api.ResultController do
  use Timelix.Web, :controller

  alias Timelix.Result

  plug :scrub_params, "result" when action in [:create, :update]
  plug :action

  def index(conn, _params) do
    results = Repo.all(Result)
    render(conn, "index.json", results: results)
  end

  def create(conn, %{"result" => result_params}) do
    changeset = Result.changeset(%Result{}, result_params)

    if changeset.valid? do
      result = Repo.insert(changeset)
      render(conn, "show.json", result: result)
    else
      conn
      |> put_status(:unprocessable_entity)
      |> render(Timelix.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    result = Repo.get(Result, id)
    render conn, "show.json", result: result
  end

  def update(conn, %{"id" => id, "result" => result_params}) do
    result = Repo.get(Result, id)
    changeset = Result.changeset(result, result_params)

    if changeset.valid? do
      result = Repo.update(changeset)
      render(conn, "show.json", result: result)
    else
      conn
      |> put_status(:unprocessable_entity)
      |> render(Timelix.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    result = Repo.get(Result, id)

    result = Repo.delete(result)
    render(conn, "show.json", result: result)
  end
end
