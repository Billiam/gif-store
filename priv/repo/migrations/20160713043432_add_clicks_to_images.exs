defmodule Giftrap.Repo.Migrations.AddClicksToImages do
  use Ecto.Migration

  def change do
    alter table(:images) do
      add :clicks, :integer, default: 0
    end
  end
end
