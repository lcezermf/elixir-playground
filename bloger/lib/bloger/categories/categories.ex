defmodule Bloger.Categories do
  @moduledoc """
  The Categories context.
  """

  import Ecto.Query, warn: false
  alias Bloger.Repo
  alias Bloger.Categories.Category

  def create_category(attrs \\ %{}) do
    %Category{}
    |> Category.changeset(attrs)
    |> Repo.insert()
  end

  def list_categories() do
    Category
    |> Repo.all()
  end
end
