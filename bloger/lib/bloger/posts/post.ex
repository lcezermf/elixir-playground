defmodule Bloger.Posts.Post do
  @moduledoc """
  Category schema.
  """
  use Ecto.Schema
  import Ecto.Changeset
  alias Bloger.Categories.Category

  schema "posts" do
    field :title, :string
    field :content, :string

    belongs_to :category, Category

    timestamps()
  end

  @doc false
  def changeset(category, attrs) do
    category
    |> cast(attrs, [:title, :content, :category_id])
    |> validate_required([:title, :content, :category_id])
  end
end
