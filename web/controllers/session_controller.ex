defmodule Giftrap.SessionController do
  use Giftrap.Web, :controller

  def new(conn, _params) do
    render conn, "new.html"
  end
  
  def create(conn, %{"session" => %{"email" => email, "password" => pass }}) do
    case Giftrap.Auth.login_by_email_and_pass(conn, email, pass, repo: Repo) do
      {:ok, conn} ->
        conn
        |> put_flash(:info, "Logged in")
        |> redirect(to: image_path(conn, :index))
      {:error, _status, conn} ->
        conn
        |> put_flash(:error, "Wrong email or password")
        |> render("new.html")
    end
  end
  
  def delete(conn, _) do
    conn
    |> Giftrap.Auth.logout()
    |> put_flash(:info, "Logged out")
    |> redirect(to: session_path(conn, :new))
  end
end