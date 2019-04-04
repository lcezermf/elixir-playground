defmodule ModuleOneTest do
  use ExUnit.Case, async: false

  import Mock

  alias ModuleOne
  alias ModuleTwo

  test "test with assert called()" do
    with_mock ModuleTwo, [name: fn(name) -> name end] do
      ModuleOne.name()

      assert called(ModuleTwo.name("name"))
    end
  end

  test "test with assert_called()" do
    with_mock ModuleTwo, [name: fn(name) -> name end] do
      ModuleOne.name()

      assert_called(ModuleTwo.name("name"))
    end
  end
end
