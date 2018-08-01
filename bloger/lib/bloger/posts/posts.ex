defmodule Bloger.Posts do
  @moduledoc """
  The Posts context.
  """

  import Ecto.Query, warn: false
  alias Bloger.Repo
  alias Bloger.Posts.Post

  def create_post(attrs \\ %{}) do
    %Post{} # Struct
    |> Post.changeset(attrs) # Schema.changeset
    |> Repo.insert()
  end

  def list_posts() do
    Post
    |> order_by(asc: :title)
    |> Repo.all()
  end

  def list_posts_by_category(category_id) do
    Post
    |> where(category_id: ^category_id)
    |> order_by(asc: :title)
    |> Repo.all()
  end
end
