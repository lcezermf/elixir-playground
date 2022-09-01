defmodule PowerNap do
  def nap do
    time = :rand.uniform(10_000)
    :timer.sleep(time)
    time
  end
end

receive do {:slept, timer} -> "Slept #{timer} ms" end
