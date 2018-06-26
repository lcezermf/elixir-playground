defmodule Anagram do
  def validate(word_a, word_b) do
    cond do
      !is_binary(word_a) || !is_binary(word_b) || invalid_string(word_a) || invalid_string(word_b) ->
        raise RuntimeError, message: "must fill arguments with 2 valid strings"
      true ->
        anagrams?(word_a, word_b)
    end
  end

  defp invalid_string(word) do
    String.length(String.trim(word)) == 0
  end

  defp anagrams?(word_a, word_b) do
    if sort_string(word_a) == sort_string(word_b) do
      "Anagram!"
    else
      "Not an Anagram!"
    end
  end

  defp sort_string(word) do
    word
    |> String.downcase()
    |> String.graphemes()
    |> Enum.sort
  end
end
