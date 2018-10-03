defmodule Identicon do
  @moduledoc """
  Documentation for Identicon.
  """

  @doc """
    Receive an input and return the binary list

  ## Examples

      iex> Identicon.main("cezer")
      [215, 74, 51, 183, 150, 218, 88, 75, 130, 1, 142, 146, 156, 38, 182, 28]
  """
  def main(input) do
    input
    |> hash_input
    |> pick_color
  end

  defp hash_input(input) do
    hex = :crypto.hash(:md5, input)
    |> :binary.bin_to_list

    %Identicon.Image{hex: hex}
  end

  defp pick_color(%{hex: [r, g, b | _tail]} = image) do
    %Identicon.Image{image | color: {r, g, b}}
  end
end