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
end
