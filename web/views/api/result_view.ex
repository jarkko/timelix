defmodule Timelix.Api.ResultView do
  use Timelix.Web, :view

  def render("index.json", %{results: results}) do
    %{results: render_many(results, Timelix.Api.ResultView, "result.json")}
  end

  def render("show.json", %{result: result}) do
    %{result: render_one(result, Timelix.Api.ResultView, "result.json")}
  end

  def render("result.json", %{result: result}) do
    %{id: result.id, bib_number: result.bib_number, result: result.result, timer_id: result.timer_id}
  end
end
