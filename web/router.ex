defmodule Timelix.Router do
  use Timelix.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Timelix do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index

    resources "/results", ResultController
    resources "/runners", RunnerController
    resources "/timers", TimerController
  end

  scope "/api", Timelix.Api, as: :api do
    pipe_through :api

    resources "/results", ResultController
    resources "/timers",  TimerController
  end

  socket "/ws", Timelix do
    channel "rooms:*", TimerChannel
  end

  # Other scopes may use custom stacks.
  # scope "/api", Timelix do
  #   pipe_through :api
  # end
end
