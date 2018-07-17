defmodule BlogerWeb.CategoriesViewTest do
  use BlogerWeb.ConnCase

  alias BlogerWeb.CategoriesView
  alias Bloger.Categories.Category

  test "category_json/1" do
    category = Bloger.Repo.insert!(%Category{title: "My title #"})

    rendered_category = CategoriesView.category_json(category)

    assert rendered_category == %{
      id: category.id,
      title: category.title
    }
  end

  test "index.json" do
    category = Bloger.Repo.insert!(%Category{title: "My title #1"})
    category_two = Bloger.Repo.insert!(%Category{title: "My title #2"})

    categories = CategoriesView.render("index.json", %{categories: [category, category_two]})

    assert categories == %{
      categories: [
        CategoriesView.category_json(category),
        CategoriesView.category_json(category_two),
      ]
    }
  end
end
