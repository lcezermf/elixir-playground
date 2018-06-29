defmodule Anagram do
  def validate(word_a, word_b) do
    cond do
      invalid_string(word_a) || invalid_string(word_b) ->
        raise RuntimeError, message: "must fill arguments with 2 valid strings"
      true ->
        anagrams?(word_a, word_b)
    end
  end

  def invalid_string(word) do
    !is_binary(word) || blank_string(word)
  end

  defp blank_string(word) do
    String.length(String.trim(word)) == 0
  end

  defp anagrams?(word_a, word_b) do
    if sort_string(word_a) == sort_string(word_b), do: "Anagram!", else: "Not an Anagram!"
  end

  defp sort_string(word) do
    word
    |> String.downcase()
    |> String.graphemes()
    |> Enum.sort
  end
end
