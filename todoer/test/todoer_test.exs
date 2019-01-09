defmodule TodoerTest do
  use ExUnit.Case
  doctest Todoer

  setup_all do
    {:ok, todo_list: %{}}
  end

  describe ".new" do
    test "must return new Todoer instance", state do
      assert Todoer.new() == state[:todo_list]
    end
  end

  describe ".add_entry/3" do
    test "must add a new entry", state do
      details = %{date: {2019, 18, 1}, title: "Go to Dentist!"}

      assert %{{2019, 18, 1} => ["Go to Dentist!"]} ==
               Todoer.add_entry(state[:todo_list], details)
    end
  end

  describe ".entries/2" do
    test "must return entries for a given date", state do
      details = %{date: {2019, 18, 1}, title: "Go to Dentist!"}

      new_todo = Todoer.add_entry(state[:todo_list], details)

      assert ["Go to Dentist!"] == Todoer.entries(new_todo, details.date)
    end

    test "return empty list for a date with no todo", state do
      assert [] == Todoer.entries(state[:todo_list], {2019, 18, 1})
    end
  end
end
