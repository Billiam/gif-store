defmodule Giftrap.TagsController do
  use Giftrap.Web, :controller

  plug Giftrap.Authenticated

  alias Giftrap.Image
  
  def action(conn, _) do
    apply(__MODULE__, action_name(conn),
      [conn, conn.params, conn.assigns.current_user])
  end
  
  def index(conn, params, user) do
    tags = list_tags(params, user)
    render(conn, "index.json", tags: tags)
  end
  
  defp list_tags(%{"q" => search}, user), do:  Image.find_tags(search, user.id)
  defp list_tags(_params, user), do: Image.find_tags(user.id)
end
