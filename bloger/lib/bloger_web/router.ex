defmodule BlogerWeb.Router do
  use BlogerWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", BlogerWeb do
    pipe_through :api
  end
end
