defmodule TodoerTest do
  use ExUnit.Case
  doctest Todoer

  describe ".new" do
    test "must return new Todoer instance" do
      assert Todoer.new() == %{}
    end
  end

  describe ".add_entry/3" do
    test "must add a new entry" do
      todo_list = Todoer.new()
      details = %{date: {2019, 18, 1}, title: "Go to Dentist!"}

      assert %{{2019, 18, 1} => ["Go to Dentist!"]} == Todoer.add_entry(todo_list, details)
    end
  end

  describe ".entries/2" do
    test "must return entries for a given date" do
      todo_list = Todoer.new()
      details = %{date: {2019, 18, 1}, title: "Go to Dentist!"}

      new_todo = Todoer.add_entry(todo_list, details)

      assert ["Go to Dentist!"] == Todoer.entries(new_todo, details.date)
    end

    test "return empty list for a date with no todo" do
      todo_list = Todoer.new()
      date = {2019, 18, 1}

      assert [] == Todoer.entries(todo_list, date)
    end
  end
end
