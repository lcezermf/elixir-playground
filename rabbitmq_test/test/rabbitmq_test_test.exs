defmodule RabbitmqTestTest do
  use ExUnit.Case
  doctest RabbitmqTest

  test "greets the world" do
    assert RabbitmqTest.hello() == :world
  end
end
