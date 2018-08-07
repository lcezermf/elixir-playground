defmodule BlogerWeb.PostsView do
  use BlogerWeb, :view
  alias BlogerWeb.PostsView

  def render("index.json", %{posts: posts}) do
    %{posts: render_many(posts, PostsView, "post.json", as: :post)}
  end

  def render("post.json", %{post: post}) do
    %{
      id: post.id,
      title: post.title,
      category: post.category.title
    }
  end

  # Alt.
  #
  # def render("index.json", %{posts: posts}) do
  #   %{
  #     posts: Enum.map(posts, fn(post) -> post_json(post) end)
  #   }
  # end
  #
  # def post_json(post) do
  #   %{
  #     id: post.id,
  #     title: post.title,
  #     category: post.category.title
  #   }
  # end
end
