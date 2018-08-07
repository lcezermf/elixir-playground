defmodule Bloger.Categories.Category do
  @moduledoc """
  Category schema.
  """
  use Ecto.Schema
  import Ecto.Changeset
  alias Bloger.Posts.Post

  schema "categories" do
    field :title, :string

    has_many :posts, Post

    timestamps()
  end

  @doc false
  def changeset(category, attrs) do
    category
    |> cast(attrs, [:title])
    |> validate_required([:title])
  end
end
