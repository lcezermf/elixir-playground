defmodule BlogerWeb.PostsControllerTest do
  use BlogerWeb.ConnCase

  # USE FIXTURE TO REMOTE IT ASAP!
  alias Bloger.Posts
  alias Bloger.Posts.Post
  alias Bloger.Categories.Category
  alias Bloger.Repo

  describe "GET index action" do
    test "must return a json with data", %{conn: conn} do
      {:ok, c} = Bloger.Repo.insert(%Category{title: "Category"})
      post = Bloger.Repo.insert!(%Post{title: "My title", content: "My Content", category_id: c.id})
      post = Repo.preload(post, :category)

      response = get conn, posts_path(conn, :index)

      expected_json_response = %{
        "posts" => [%{
          "id" => post.id,
          "title" => post.title,
          "category" => post.category.title
        }]
      }

      assert json_response(response, 200) == expected_json_response
    end
  end
end
