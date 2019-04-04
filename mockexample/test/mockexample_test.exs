defmodule MockexampleTest do
  use ExUnit.Case
  doctest Mockexample

  test "greets the world" do
    assert Mockexample.hello() == :world
  end
end
