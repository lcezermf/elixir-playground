defmodule Bloger.Repo.Migrations.CreatePosts do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :title, :string
      add :content, :text

      add :category_id, references(:categories)

      timestamps()
    end

    create index(:posts, [:category_id])
  end
end
