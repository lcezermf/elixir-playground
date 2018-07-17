defmodule BlogerWeb.CategoriesView do
  use BlogerWeb, :view
  # alias BlogerWeb.CategoriesView
  #
  # def render("index.json", %{categories: categories}) do
  #   %{categories: render_many(categories, CategoriesView, "category.json", as: :category)}
  # end
  #
  # def render("category.json", %{category: category}) do
  #   %{
  #     id: category.id,
  #     title: category.title
  #   }
  # end
  def render("index.json", %{categories: categories}) do
    %{
      categories: Enum.map(categories, fn(category) -> category_json(category) end)
    }
  end

  def category_json(category) do
    %{
      id: category.id,
      title: category.title
    }
  end
end
