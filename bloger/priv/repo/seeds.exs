# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Bloger.Repo.insert!(%Bloger.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

{:ok, category} = Bloger.Repo.insert(%Bloger.Categories.Category{title: "First category"})
{:ok, categorytwo} = Bloger.Repo.insert(%Bloger.Categories.Category{title: "Second category"})
Bloger.Repo.insert(%Bloger.Posts.Post{title: "First Post", content: "First content post", category_id: category.id})
Bloger.Repo.insert(%Bloger.Posts.Post{title: "Second Post", content: "Second content post", category_id: categorytwo.id})
