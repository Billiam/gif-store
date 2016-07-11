defmodule Giftrap.TagHelpers do
  def tag_url(conn, tag) when is_binary(tag) do
     Giftrap.Router.Helpers.image_path(conn, :index, search: [q: tag])
  end
end
