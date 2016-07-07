defmodule Giftrap.Authenticated do
  import Plug.Conn
  import Giftrap.Router.Helpers, only: [page_path: 2]


  def init(options), do: options
  
  def call(conn, _) do
    if conn.assigns.current_user do
      conn
    else
      conn
      |> Phoenix.Controller.put_flash(:error, "You must be logged in to access that page")
      |> Phoenix.Controller.redirect(to: page_path(conn, :index))
      |> halt()
    end
  end
end