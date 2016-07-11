defmodule Giftrap.ImageController do
  use Giftrap.Web, :controller

  plug Giftrap.Authenticated

  alias Giftrap.Image
  
  def action(conn, _) do
    apply(__MODULE__, action_name(conn),
      [conn, conn.params, conn.assigns.current_user])
  end
  
  def index(conn, params, user) do
    images = list_images(user.id, params) |> Giftrap.Repo.all
    tags = Image.find_tags(user.id)
    render(conn, "index.html", images: images, tags: tags)
  end
  
  def new(conn, _params, user) do
    changeset = user
    |> build_assoc(:images)
    |> Image.changeset()
    
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"image" => image_params}, user) do
    changeset = user
    |> build_assoc(:images)
    |> Image.changeset(image_params)

    case Repo.insert(changeset) do
      {:ok, _image} ->
        conn
        |> put_flash(:info, "Image created successfully.")
        |> redirect(to: image_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}, user) do
    image = Repo.get!(user_images(user), id)
    render(conn, "show.html", image: image)
  end

  def edit(conn, %{"id" => id}, user) do
    image = Repo.get!(user_images(user), id) |> Image.populate
    changeset = Image.changeset(image)
    render(conn, "edit.html", image: image, changeset: changeset)
  end

  def update(conn, %{"id" => id, "image" => image_params}, user) do
    image = Repo.get!(user_images(user), id)
    changeset = Image.changeset(image, image_params)

    case Repo.update(changeset) do
      {:ok, image} ->
        conn
        |> put_flash(:info, "Image updated successfully.")
        |> redirect(to: image_path(conn, :show, image))
      {:error, changeset} ->
        render(conn, "edit.html", image: Image.populate(image), changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}, user) do
    image = Repo.get!(user_images(user), id)
    Repo.delete!(image)

    conn
    |> put_flash(:info, "Image deleted successfully.")
    |> redirect(to: image_path(conn, :index))
  end
  
  defp user_images(user) do
    assoc(user, :images)
  end
  
  defp list_images(user_id, %{"search" => %{"q" => terms}}) when is_binary(terms) do
    list_images(user_id, %{})
    |> Image.search(terms)
  end
    
  defp list_images(user_id, _) do
    Image |>
    Image.by_user(user_id)
  end
end
