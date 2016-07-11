defmodule Giftrap.TagsView do
  use Giftrap.Web, :view
  
  def render("index.json", %{tags: tags}) do
    %{data: render_many(tags, Giftrap.TagsView, "tags.json")}
  end

  def render("tags.json", %{tags: tags}) do
    tags
  end
end
