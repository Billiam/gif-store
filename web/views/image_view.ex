defmodule Giftrap.ImageView do
  use Giftrap.Web, :view
  
  def render("click.json", _) do
    %{data: :ok}
  end
end
