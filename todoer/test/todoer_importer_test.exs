defmodule Todoer.CSVImporterTest do
  use ExUnit.Case
  doctest Todoer

  alias Todoer
  alias Todoer.CSVImporter

  setup_all do
    {:ok, file_path: "./todos.csv"}
  end

  describe ".import/1" do
    test "must open file and return an array of tuple with {{year, month, day}, title}", state do
      %{entries: entries} = CSVImporter.import(state[:file_path])

      assert %{
               1 => %{date: {2013, 12, 19}, id: 1, title: "Dentist"},
               2 => %{date: {2013, 12, 20}, id: 2, title: "Supermarket"}
             } = entries
    end
  end
end
