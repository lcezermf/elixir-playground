defmodule TodoerTest do
  use ExUnit.Case
  doctest Todoer

  alias Todoer

  setup_all do
    {:ok, todo_list: %Todoer{}}
  end

  describe ".new" do
    test "must return new Todoer instance", state do
      assert Todoer.new() == state[:todo_list]
    end
  end

  describe ".add_entry/3" do
    test "must add a new entry", state do
      entry = %{date: {2019, 18, 1}, title: "Go to Dentist!"}

      assert %Todoer{
               auto_id: 2,
               entries: %{
                 1 => %{date: {2019, 18, 1}, id: 1, title: "Go to Dentist!"}
               }
             } == Todoer.add_entry(state[:todo_list], entry)
    end
  end

  describe ".entries/2" do
    test "must return entries for a given date", state do
      entry = %{date: {2019, 18, 1}, title: "Go to Dentist!"}
      entry_two = %{date: {2019, 18, 2}, title: "Go to Supermarket!"}

      entries =
        state[:todo_list]
        |> Todoer.add_entry(entry)
        |> Todoer.add_entry(entry_two)

      assert [%{date: {2019, 18, 1}, id: 1, title: "Go to Dentist!"}] ==
               Todoer.entries(entries, entry.date)
    end

    test "return empty list for a date with no todo", state do
      assert [] == Todoer.entries(state[:todo_list], {2019, 18, 1})
    end
  end
end
