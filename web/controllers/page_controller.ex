defmodule Timelix.PageController do
  use Timelix.Web, :controller

  plug :action

  def index(conn, _params) do
    render conn, "index.html"
  end
end
