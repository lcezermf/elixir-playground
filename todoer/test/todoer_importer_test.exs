defmodule Todoer.CSVImporterTest do
  use ExUnit.Case
  doctest Todoer

  alias Todoer.CSVImporter

  setup_all do
    {:ok, file_path: "./todos.csv"}
  end

  describe ".import/1" do
    test "must open file and return an array of tuple with {{year, month, day}, title}", state do
      assert [
               {{2013, 12, 19}, "Dentist"},
               {{2013, 12, 20}, "Supermarket"}
             ] = CSVImporter.import(state[:file_path])
    end
  end
end
