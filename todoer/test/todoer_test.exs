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
      date = {2019, 18, 1}
      title = "Go to Dentist!"

      assert %{{2019, 18, 1} => ["Go to Dentist!"]} == Todoer.add_entry(todo_list, date, title)
    end
  end
end
