defmodule Giftrap.Repo.Migrations.IndexImageTags do
  use Ecto.Migration

  def change do
    create index(:images, [:tags], using: :gin)
  end
end
