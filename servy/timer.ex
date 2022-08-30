defmodule Timer do
  def remind(description, time_in_future) do
    spawn(fn -> do_remind(description, time_in_future) end)
  end

  defp do_remind(description, time_in_future) do
    :timer.sleep(time_in_future)
    IO.puts(description)
  end
end

Timer.remind("Clean up", 10_000)
Timer.remind("Wash Dishes", 3_000)
Timer.remind("Dog walk!", 6_000)
