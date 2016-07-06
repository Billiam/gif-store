defmodule Vagrant.PageController do
  use Vagrant.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
