defmodule Hello.Person do
  use Ecto.Schema
  import Ecto.Changeset

  schema "person" do
    field :name
    field :age
  end

  @doc false
  def changeset(person, attrs) do
    person
    |> cast(attrs, [:name, :age])
    |> validate_required([:name])
  end
end
