defmodule AnagramTest do
  use ExUnit.Case
  doctest Anagram

  test "must raise error with non string as argument" do
    assert_raise RuntimeError, "must fill arguments with 2 valid strings", fn ->
      Anagram.validate(3, 10)
      Anagram.validate(nil, false)
      Anagram.validate(true, "")
    end
  end

  test "must raise error with blank string as argument" do
    assert_raise RuntimeError, "must fill arguments with 2 valid strings", fn ->
      Anagram.validate("", "word")
      Anagram.validate("word", "")
    end
  end

  test "show error message when words are not an anagram" do
    assert Anagram.validate("xunda", "banana") == "Not an Anagram!"
  end

  test "show success message when words are an anagram" do
    assert Anagram.validate("luiz", "zilu") == "Anagram!"
  end
end
