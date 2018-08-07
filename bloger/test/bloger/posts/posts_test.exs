defmodule Bloger.PostsTest do
  use Bloger.DataCase
  alias Bloger.Posts
  alias Bloger.Categories.Category
  alias Bloger.Posts.Post

  describe "create_post/1" do
    test "with valid data must create a new category" do
      {:ok, c} = Bloger.Repo.insert(%Category{title: "Category"})
      params = %{title: "Post Title", content: "Post Content", category_id: c.id}

      assert {:ok, post} = Posts.create_post(params)

      assert post.title == params.title
    end

    test "with invalid data must return an error" do
      params = %{title: ""}

      {:error, changeset_errors} = Posts.create_post(params)

      assert "can't be blank" in errors_on(changeset_errors).title
      assert {:error, %Ecto.Changeset{}} = Posts.create_post(params)
    end
  end

  describe "list_posts" do
    test "return a list of all posts sorted by title" do
      {:ok, c} = Bloger.Repo.insert(%Category{title: "Category"})
      posttwo = Bloger.Repo.insert!(%Post{title: "Xunda Title", content: "Post Content", category_id: c.id})
      postone = Bloger.Repo.insert!(%Post{title: "Post Title", content: "Post Content", category_id: c.id})
      postthree = Bloger.Repo.insert!(%Post{title: "Another Title", content: "Post Content", category_id: c.id})

      posts = Posts.list_posts()
      ids = Enum.map(posts, fn(p) -> p.id end)

      assert Enum.at(ids, 0) == postthree.id
      assert Enum.at(ids, 1) == postone.id
      assert Enum.at(ids, 2) == posttwo.id
    end
  end

  describe "list_posts_by_category" do
    test "return posts inside given category" do
      {:ok, c1} = Bloger.Repo.insert(%Category{title: "Category #1"})
      {:ok, c2} = Bloger.Repo.insert(%Category{title: "Category #2"})

      post2 = Bloger.Repo.insert!(%Post{title: "Xunda Title", content: "Post Content", category_id: c1.id})
      post1 = Bloger.Repo.insert!(%Post{title: "Post Title", content: "Post Content", category_id: c1.id})
      post3 = Bloger.Repo.insert!(%Post{title: "Another Title", content: "Post Content", category_id: c2.id})

      posts = Posts.list_posts_by_category(c1.id)
      ids = Enum.map(posts, fn(p) -> p.id end)
      categories = Enum.map(posts, fn(p) -> p.category.title end)

      assert post2.id in ids
      assert post1.id in ids
      refute post3.id in ids
      assert c1.title in categories
    end
  end
end
