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

    test "enable multiple entries in a single time" do
      entries = [
        %{date: {2019, 10, 19}, title: "Go to Supermarket"},
        %{date: {2019, 06, 01}, title: "My birthday"},
        %{date: {2019, 07, 10}, title: "Go to dentist"}
      ]

      %{entries: entries} = Todoer.new(entries)

      assert length(Map.keys(entries)) == 3
    end
  end

  describe ".add_entry/2" do
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
        |> Todoer.add_entry(%{date: {2019, 18, 1}, title: "Go to Dentist!"})
        |> Todoer.add_entry(%{date: {2019, 18, 2}, title: "Go to Supermarket!"})

      assert [%{date: {2019, 18, 1}, id: 1, title: "Go to Dentist!"}] ==
               Todoer.entries(entries, entry.date)
    end

    test "return empty list for a date with no todo", state do
      assert [] == Todoer.entries(state[:todo_list], {2019, 18, 1})
    end
  end

  describe ".update_entry/2" do
    test "given a valid ID must update the entry", state do
      old_date = {2019, 18, 1}
      todo_list = Todoer.add_entry(state[:todo_list], %{date: old_date, title: "Go to Dentist!"})

      new_date = {2020, 2, 10}
      updated_entries = Todoer.update_entry(todo_list, 1, &Map.put(&1, :date, new_date))
      {_, updated_entry} = Enum.at(updated_entries.entries, 0)

      assert length(Map.keys(todo_list.entries)) == 1

      assert updated_entry.date == new_date
      refute updated_entry.date == old_date
    end

    test "given an INVALID ID must do nothing", state do
      todo_list =
        Todoer.add_entry(state[:todo_list], %{date: {2019, 18, 1}, title: "Go to Dentist!"})

      updated_entries = Todoer.update_entry(todo_list, 10, &Map.put(&1, :title, "Another Title"))

      assert todo_list.entries == updated_entries.entries

      {_, entry} = Enum.at(todo_list.entries, 0)
      assert entry.title == "Go to Dentist!"
    end
  end

  describe ".delete_entry/1" do
    test "given a valid ID must delete the entry", state do
      todo_list =
        state[:todo_list]
        |> Todoer.add_entry(%{date: {2019, 19, 1}, title: "Go to Dentist!"})
        |> Todoer.add_entry(%{date: {2019, 22, 1}, title: "Go to Supermarket!"})

      %{entries: remaining_entries} = Todoer.delete_entry(todo_list, 1)

      assert %{2 => %{date: {2019, 22, 1}, id: 2, title: "Go to Supermarket!"}} ==
               remaining_entries
    end

    test "given an invalid ID must return default list error", state do
      todo_list =
        state[:todo_list]
        |> Todoer.add_entry(%{date: {2019, 19, 1}, title: "Go to Dentist!"})
        |> Todoer.add_entry(%{date: {2019, 22, 1}, title: "Go to Supermarket!"})

      entries = Todoer.delete_entry(todo_list, 10)

      assert entries == todo_list
    end
  end
end
