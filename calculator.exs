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

  def loop(current_value) do
    new_value =
      receive do
        {:value, caller} ->
          send(caller, {:response, current_value})
          current_value

        {:add, value} ->
          current_value + value

        {:sub, value} ->
          current_value - value

        {:mul, value} ->
          current_value * value

        {:div, value} ->
          current_value / value
      end

    loop(new_value)
  end
end
