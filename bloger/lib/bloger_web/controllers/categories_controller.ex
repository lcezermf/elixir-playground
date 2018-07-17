defmodule BlogerWeb.CategoriesController do
  use BlogerWeb, :controller
  alias Bloger.Categories

  def index(conn, _params) do
    categories = Categories.list_categories()
    render(conn, "index.json", categories: categories)
  end
end
