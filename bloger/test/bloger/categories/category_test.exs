defmodule Bloger.Categories.CategoryTest do
  use Bloger.DataCase
  alias Bloger.Categories.Category

  describe "validations" do
    test "title must be required" do
      category = %Category{}
      changeset = Category.changeset(category, %{})

      assert !changeset.valid?
      assert "can't be blank" in errors_on(changeset).title
    end

    test "valid struct" do
      category = %Category{title: "First Category"}
      changeset = Category.changeset(category, %{})

      assert changeset.valid?
    end
  end
end
