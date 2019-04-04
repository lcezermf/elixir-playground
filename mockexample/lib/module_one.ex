defmodule ModuleOne do
  alias ModuleTwo
  def name do
    IO.puts("ModuleOne: name")
    ModuleTwo.name("name")
  end
end
