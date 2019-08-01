defmodule FamilyForeverPhoenixWeb.Router do
  use FamilyForeverPhoenixWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", FamilyForeverPhoenixWeb.Api do
    pipe_through :api

    scope "/slack", Slack do
      scope "/slash", Slash do
        resources "/countdown", CountdownController, only: [:create]
        resources "/pokedex", PokedexController, only: [:create]
      end
    end
  end

  scope "/", FamilyForeverPhoenixWeb do
    pipe_through :browser

    get "/", PageController, :index
  end
end
