alias Giftrap.Router.Helpers

defmodule Giftrap.Authenticated do
  import Plug.Conn

  def init(options), do: options
  
  def call(conn, _) do
    if conn.assigns.current_user do
      conn
    else
      conn
      |> Phoenix.Controller.put_flash(:error, "You must be logged in to access that page")
      |> Phoenix.Controller.redirect(to: Helpers.session_path(conn, :new))
      |> halt()
    end
  end
end