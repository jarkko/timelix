defmodule Timelix.Api.RunnerView do
  use Timelix.Web, :view

  def render("index.json", %{runners: runners}) do
    %{data: render_many(runners, "runner.json")}
  end

  def render("show.json", %{runner: runner}) do
    %{data: render_one(runner, "runner.json")}
  end

  def render("runner.json", %{runner: runner}) do
    %{id: runner.id}
  end
end
