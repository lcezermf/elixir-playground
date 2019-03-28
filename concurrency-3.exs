defmodule ConcurrencyThree do
  def listen do
    receive do
      {:ok, "hello"} -> IO.puts("World!")
    end

    listen()
  end
end

pid = spawn(ConcurrencyThree, :listen, [])

send(pid, {:ok, "hello"})

send(pid, {:ok, "nothing"})
