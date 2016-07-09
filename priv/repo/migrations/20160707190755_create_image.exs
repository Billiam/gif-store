defmodule Giftrap.Repo.Migrations.CreateImage do
  use Ecto.Migration

  def change do
    create table(:images) do
      add :url, :string
      add :tags, {:array, :string}, default: []
      add :user_id, references(:users, on_delete: :delete_all)

      timestamps()
    end
    
    create index(:images, [:user_id])
  end
end
