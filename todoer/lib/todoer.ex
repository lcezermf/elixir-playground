defmodule Todoer do
  @moduledoc """
  Documentation for Todoer.
  """
  defstruct auto_id: 1, entries: Map.new()

  @doc """
  Returns a Todoer new instance

  You can also starts the new instance with multiple entries

  ## Examples

      iex> Todoer.new()
      %Todoer{auto_id: 1, entries: %{}}

      iex> entries = [%{date: {2019, 10, 19}, title: "Go to Supermarket"}, %{date: {2019, 06, 01}, title: "My birthday"}, %{date: {2019, 07, 10}, title: "Go to dentist"}]
      iex> Todoer.new(entries)
      %Todoer{
        auto_id: 4,
        entries: %{
          1 => %{date: {2019, 10, 19}, id: 1, title: "Go to Supermarket"},
          2 => %{date: {2019, 6, 1}, id: 2, title: "My birthday"},
          3 => %{date: {2019, 7, 10}, id: 3, title: "Go to dentist"}
        }
      }
  """
  def new(entries \\ []) do
    Enum.reduce(
      entries,
      %Todoer{},
      fn entry, todo_list ->
        add_entry(todo_list, entry)
      end
    )
  end

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

  @doc """
  Remove an entry information based on the ID and return the remaing list

  When given ID is invalid, must return the current list without any change.

  ## Examples

    iex> todo_list = Todoer.new() |> Todoer.add_entry(%{date: {2019, 18, 1}, title: "Go to Dentist!"}) |> Todoer.add_entry(%{date: {2019, 18, 2}, title: "Go to Work!"})
    iex> Todoer.delete_entry(todo_list, 1)
    %Todoer{
              auto_id: 3,
              entries: %{
                2 => %{date: {2019, 18, 2}, id: 2, title: "Go to Work!"}
              }
            }

  """
  def delete_entry(%Todoer{entries: entries} = todo_list, entry_id) do
    remaining_entries = Map.delete(entries, entry_id)
    %Todoer{todo_list | entries: remaining_entries}
  end
end

defmodule Todoer.CSVImporter do
  def import(file_path) do
    file_path
    |> read_lines()
    |> create_entries()
    |> Todoer.new()
  end

  defp read_lines(file_path) do
    File.stream!(file_path)
    |> Stream.map(&String.replace(&1, "\n", ""))
  end

  defp create_entries(lines) do
    lines
    |> Stream.map(&extract_data/1)
    |> Enum.map(&create_entry/1)
  end

  defp extract_data(line) do
    line
    |> String.split(",")
    |> manipulate_data()
  end

  defp manipulate_data([date_string, title]) do
    {convert_do_date(date_string), title}
  end

  defp convert_do_date(date_string) do
    [year, month, day] =
      date_string
      |> String.split("/")
      |> Enum.map(&String.to_integer/1)

    {year, month, day}
  end

  defp create_entry({date, title}) do
    %{date: date, title: title}
  end
end
