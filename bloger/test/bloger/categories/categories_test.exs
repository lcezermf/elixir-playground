defmodule Bloger.CategoriesTest do
  use Bloger.DataCase
  alias Bloger.Categories
  alias Bloger.Categories.Category

  describe "create_category/1" do
    test "with valid data must craete a new category" do
      params = %{title: "My title"}

      assert {:ok, category} = Categories.create_category(params)

      assert category.title == params.title
    end

    test "with invalid data must return an error" do
      params = %{title: ""}

      {:error, changeset_errors} = Categories.create_category(params)

      assert "can't be blank" in errors_on(changeset_errors).title
      assert {:error, %Ecto.Changeset{}} = Categories.create_category(params)
    end
  end

  describe "list_categories" do
    test "return a list of categories" do
      category = Bloger.Repo.insert!(%Category{title: "My title"})
      categories = Categories.list_categories()

      ids = Enum.map(categories, fn(c) -> c.id end)
      assert category.id in ids
    end
  end
end
