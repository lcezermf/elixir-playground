defmodule Todoer do
  @moduledoc """
  Documentation for Todoer.
  """

  @doc """
  Returns a Todoer new instance

  ## Examples

      iex> Todoer.new()
      %{}
  """
  def new, do: Map.new()

  @doc """
  Add a new todo entry

  ## Examples

      iex> todo_list = Todoer.new()
      iex> Todoer.add_entry(todo_list, {2019, 18, 1}, "Go to Dentist!")
      %{{2019, 18, 1} => ["Go to Dentist!"]}
  """
  def add_entry(todo_list, date, title) do
    Map.update(
      todo_list,
      date,
      [title],
      fn titles -> [title | titles] end
    )
  end

  @doc """
  Fetch all entries for a given date

  If there aren't no todos for a given date will return an empty list

  ## Examples

    iex> todo_list = Todoer.new() |> Todoer.add_entry({2019, 18, 1}, "Go to Dentist!") |> Todoer.add_entry({2019, 18, 2}, "Go to Work!")
    iex> Todoer.entries(todo_list, {2019, 18, 1})
    ["Go to Dentist!"]
  """
  def entries(todo_list, date) do
    Map.get(todo_list, date, [])
  end
end
