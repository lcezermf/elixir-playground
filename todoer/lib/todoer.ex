defmodule Todoer do
  @moduledoc """
  Documentation for Todoer.
  """
  defstruct auto_id: 1, entries: Map.new()

  @doc """
  Returns a Todoer new instance

  ## Examples

      iex> Todoer.new()
      %Todoer{auto_id: 1, entries: %{}}
  """
  def new, do: %Todoer{}

  @doc """
  Add a new todo entry

  ## Examples

      iex> todo_list = Todoer.new()
      iex> Todoer.add_entry(todo_list, %{date: {2019, 18, 1}, title: "Go to Dentist!"})
      %Todoer{
        auto_id: 2,
        entries: %{
          1 => %{date: {2019, 18, 1}, id: 1, title: "Go to Dentist!"}
        }
      }
  """
  def add_entry(%Todoer{auto_id: auto_id, entries: entries} = todo_list, entry) do
    entry = Map.put(entry, :id, auto_id)
    entries = Map.put(entries, auto_id, entry)

    %Todoer{todo_list | auto_id: auto_id + 1, entries: entries}
  end

  @doc """
  Fetch all entries for a given date

  If there aren't no todos for a given date will return an empty list

  ## Examples

    iex> todo_list = Todoer.new() |> Todoer.add_entry(%{date: {2019, 18, 1}, title: "Go to Dentist!"}) |> Todoer.add_entry(%{date: {2019, 18, 2}, title: "Go to Work!"})
    iex> Todoer.entries(todo_list, {2019, 18, 1})
    [%{date: {2019, 18, 1}, id: 1, title: "Go to Dentist!"}]
  """
  def entries(%Todoer{entries: entries}, date) do
    entries
    |> Stream.filter(fn {_, entry} -> entry.date == date end)
    |> Enum.map(fn {_, entry} -> entry end)
  end

  @doc """
  Update an entry information based on the ID

  When given ID is invalid, must return the current list without any change.

  ## Examples

    iex> todo_list = Todoer.new() |> Todoer.add_entry(%{date: {2019, 18, 1}, title: "Go to Dentist!"}) |> Todoer.add_entry(%{date: {2019, 18, 2}, title: "Go to Work!"})
    iex> Todoer.update_entry(todo_list, 1, &Map.put(&1, :title, "New Title"))
    %Todoer{
              auto_id: 3,
              entries: %{
                1 => %{date: {2019, 18, 1}, id: 1, title: "New Title"},
                2 => %{date: {2019, 18, 2}, id: 2, title: "Go to Work!"}
              }
            }

  """
  # def update_entry(todo_list, entry_id, %{} = entry_new_data) do
  #   update_entry(todo_list, entry_id, fn _ -> entry_new_data end)
  # end

  def update_entry(%Todoer{entries: entries} = todo_list, entry_id, updater_fun) do
    case entries[entry_id] do
      nil ->
        todo_list

      old_entry ->
        new_entry = updater_fun.(old_entry)
        new_entries = Map.put(entries, new_entry.id, new_entry)
        %Todoer{todo_list | entries: new_entries}
    end
  end
end
