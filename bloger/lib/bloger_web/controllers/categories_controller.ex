defmodule BlogerWeb.CategoriesController do
  use BlogerWeb, :controller
  alias Bloger.Categories

  def index(conn, _params) do
    categories = Categories.list_categories()
    render(conn, "index.json", categories: categories)
  end

  def create(conn, params) do
    Categories.create_category(params)

    conn
    |> resp(201, "{}")
  end
end
