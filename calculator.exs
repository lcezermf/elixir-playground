defmodule Calculator do
  def start do
    spawn(fn ->
      initial_value = 0
      loop(initial_value)
    end)
  end

  def value(caller) do
    send(caller, {:value, self})

    receive do
      {:response, current_value} -> current_value
    end
  end

  def add(caller, value), do: send(caller, {:add, value})

  def sub(caller, value), do: send(caller, {:sub, value})

  def mul(caller, value), do: send(caller, {:mul, value})

  def div(caller, value), do: send(caller, {:div, value})

  defp loop(current_value) do
    new_value =
      receive do
        message -> process_message(current_value, message)
      end

    loop(new_value)
  end

  defp process_message(current_value, {:value, caller}) do
    send(caller, {:response, current_value})
    current_value
  end

  defp process_message(current_value, {:add, value}) do
    current_value + value
  end

  defp process_message(current_value, {:sub, value}) do
    current_value - value
  end

  defp process_message(current_value, {:mul, value}) do
    current_value * value
  end

  defp process_message(current_value, {:div, value}) do
    current_value / value
  end
end
