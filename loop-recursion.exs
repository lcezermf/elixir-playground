defmodule Example do
  def list_all(list) when length(list) <= 1 do
    [head | _] = list
    IO.puts(head)
  end

  def list_all(list) do
    [head | tail] = list
    IO.puts(head)
    list_all(tail)
  end
end

list = [1, 2, 3, 4, 5]
Example.list_all(list)
