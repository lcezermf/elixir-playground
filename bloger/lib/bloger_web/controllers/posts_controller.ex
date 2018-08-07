defmodule BlogerWeb.PostsController do
  use BlogerWeb, :controller
  alias Bloger.Posts

  def index(conn, _params) do
    posts = Posts.list_posts()
    render(conn, "index.json", posts: posts)
  end
end
