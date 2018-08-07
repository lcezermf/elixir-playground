defmodule BlogerWeb.PostsViewTest do
  use BlogerWeb.ConnCase

  alias BlogerWeb.PostsView
  alias Bloger.Categories.Category
  alias Bloger.Posts.Post
  alias Bloger.Repo

  test "post_json/1" do
    {:ok, c} = Bloger.Repo.insert(%Category{title: "Category"})
    post = Bloger.Repo.insert!(%Post{title: "My title #1", content: "Content", category_id: c.id})
    post = Repo.preload(post, :category)

    rendered_post = PostsView.render("post.json", %{post: post})

    assert rendered_post == %{
      id: post.id,
      title: post.title,
      category: post.category.title
    }
  end

  test "index.json" do
    {:ok, c} = Bloger.Repo.insert(%Category{title: "Category"})
    post = Bloger.Repo.insert!(%Post{title: "My title #1", content: "Content", category_id: c.id})
    post = Repo.preload(post, :category)
    post_two = Bloger.Repo.insert!(%Post{title: "My title #2", content: "Content", category_id: c.id})
    post_two = Repo.preload(post_two, :category)

    posts = PostsView.render("index.json", %{posts: [post, post_two]})

    assert posts == %{
      posts: [
        PostsView.render("post.json", %{post: post}),
        PostsView.render("post.json", %{post: post_two}),
      ]
    }
  end
end
