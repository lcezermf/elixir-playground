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
      postone = Bloger.Repo.insert!(%Post{title: "Post Title", content: "Post Content", category_id: c.id})
      posttwo = Bloger.Repo.insert!(%Post{title: "Xunda Title", content: "Post Content", category_id: c.id})
      postthree = Bloger.Repo.insert!(%Post{title: "Another Title", content: "Post Content", category_id: c.id})

      posts = Posts.list_posts()
      ids = Enum.map(posts, fn(p) -> p.id end)

      assert postone.id in ids
      assert posttwo.id in ids
      assert postthree.id in ids
    end
  end

  # describe "list_posts" do
  #   test "return a list of categories" do
  #     category = Bloger.Repo.insert!(%Post{title: "My title"})
  #     categories = Posts.list_categories()
  #
  #     ids = Enum.map(categories, fn(c) -> c.id end)
  #     assert category.id in ids
  #   end
  # end

  # describe "list_posts_by_category" do
  #   test "return a list of categories" do
  #     category = Bloger.Repo.insert!(%Post{title: "My title"})
  #     categories = Posts.list_categories()
  #
  #     ids = Enum.map(categories, fn(c) -> c.id end)
  #     assert category.id in ids
  #   end
  # end
end
