defmodule CardsTest do
  use ExUnit.Case
  doctest Cards

  test "create_deck must return a list of strings" do
    deck = Cards.create_deck

    assert deck |> is_list
  end

  test "create_deck must return a list with 20 cards" do
    deck = Cards.create_deck

    assert length(deck) == 20
  end

  test "shuffle a deck must randomizes it" do
    deck = Cards.create_deck

    assert deck != Cards.shuffle(deck)
  end
end
