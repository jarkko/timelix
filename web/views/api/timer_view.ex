defmodule Timelix.Api.TimerView do
  use Timelix.Web, :view

  def render("index.json", %{timers: timers}) do
    %{data: render_many(timers, "timer.json")}
  end

  def render("show.json", %{timer: timer}) do
    %{data: render_one(timer, "timer.json")}
  end

  def render("timer.json", %{timer: timer}) do
    %{id: timer.id}
  end
end
