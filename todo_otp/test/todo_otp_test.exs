defmodule TodoOTPTest do
  use ExUnit.Case
  doctest TodoOTP

  test "greets the world" do
    assert TodoOTP.hello() == :world
  end
end
