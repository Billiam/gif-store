defmodule Giftrap.Router do
  use Giftrap.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Giftrap.Auth, repo: Giftrap.Repo
  end

  pipeline :api do
    plug :accepts, ["json"]
    plug :fetch_session
    plug Giftrap.Auth, repo: Giftrap.Repo
  end

  scope "/", Giftrap do
    pipe_through :browser # Use the default browser stack

    resources "/", ImageController, only: [:index]
    resources "/users", UserController
    resources "/sessions", SessionController, only: [:new, :create, :delete]
    
    resources "/images", ImageController, except: [:index]
  end

  scope "/api/v1", Giftrap do
    pipe_through :api
    
    resources "/tags", TagsController, only: [:index]
  end
  # Other scopes may use custom stacks.
  # scope "/api", Giftrap do
  #   pipe_through :api
  # end
end
