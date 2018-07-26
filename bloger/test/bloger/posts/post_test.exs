defmodule Bloger.Posts.PostTest do
  use Bloger.DataCase
  alias Bloger.Posts.Post

  describe "validations" do
    test "title must be required" do
      post = %Post{title: "", content: "Content", category_id: 1}
      changeset = Post.changeset(post, %{})

      assert !changeset.valid?
      assert "can't be blank" in errors_on(changeset).title
    end

    test "content must be required" do
      post = %Post{title: "Title", content: "", category_id: 1}
      changeset = Post.changeset(post, %{})

      assert !changeset.valid?
      assert "can't be blank" in errors_on(changeset).content
    end

    test "category_id must be required" do
      post = %Post{title: "Title", content: "Content", category_id: nil}
      changeset = Post.changeset(post, %{})

      assert !changeset.valid?
      assert "can't be blank" in errors_on(changeset).category_id
    end
  end
end
