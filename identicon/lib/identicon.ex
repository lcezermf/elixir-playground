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
    |> build_grid
  end

  defp hash_input(input) do
    hex = :crypto.hash(:md5, input)
    |> :binary.bin_to_list

    %Identicon.Image{hex: hex}
  end

  defp pick_color(%{hex: [r, g, b | _tail]} = image) do
    %Identicon.Image{image | color: {r, g, b}}
  end

  defp build_grid(%Identicon.Image{hex: hex} = image) do
    grid = hex
    |> Enum.chunk_every(3, 3, :discard)
    |> Enum.map(&mirror_row/1)
    |> List.flatten
    |> Enum.with_index

    %Identicon.Image{image | grid: grid}
  end

  defp mirror_row([first, second | _tail] = row) do
    row ++ [second, first]
  end
end
