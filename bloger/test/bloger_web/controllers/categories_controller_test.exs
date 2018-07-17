defmodule BlogerWeb.CategoriesControllerTest do
  use BlogerWeb.ConnCase

  # USE FIXTURE TO REMOTE IT ASAP!
  alias Bloger.Categories
  alias Bloger.Categories.Category

  describe "GET index action" do
    test "must return a json with data", %{conn: conn} do
      category = Bloger.Repo.insert!(%Category{title: "My title"})

      req = get conn, categories_path(conn, :index)

      expected_json_response = %{
        "categories" => [%{
          "id" => category.id,
          "title" => category.title
        }]
      }

      assert json_response(req, 200) == expected_json_response
    end
  end
end
