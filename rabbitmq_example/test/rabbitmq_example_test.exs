defmodule RabbitmqExampleTest do
  use ExUnit.Case
  doctest RabbitmqExample

  test "greets the world" do
    assert RabbitmqExample.hello() == :world
  end
end
