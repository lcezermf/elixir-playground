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

Bloger.Repo.insert!(%Bloger.Category{name: "First category"})
Bloger.Repo.insert!(%Bloger.Category{name: "Second category"})
