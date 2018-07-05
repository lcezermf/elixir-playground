defmodule Hello.Repo.Migrations.CreatePerson do
  use Ecto.Migration

  def change do
    create table(:person) do
      add :name, :string
      add :age, :integer
    end
  end
end
