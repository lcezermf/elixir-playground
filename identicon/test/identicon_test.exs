defmodule IdenticonTest do
  use ExUnit.Case
  doctest Identicon

  test "generates a hash for a given string and return the binary list" do
    input = "cezer"

    result = Identicon.main(input)

    assert is_list(result)
  end
end
