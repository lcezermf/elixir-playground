defmodule Servy.FourOhFourCounter do
  @name __MODULE__

  # Client

  def start() do
    pid = spawn(__MODULE__, :listen_loop, [%{}])
    Process.register(pid, @name)
    pid
  end

  def bump_count(path) do
    send(@name, {self(), :bump_count, path})

    receive do
      {:response, value} -> value
    end
  end

  def get_count(path) do
    send(@name, {self(), :get_count, path})

    receive do
      {:response, value} -> value
    end
  end

  def get_counts do
    send(@name, {self(), :get_counts})

    receive do
      {:response, value} -> value
    end
  end

  # Server

  def listen_loop(state) do
    receive do
      {sender, :bump_count, path} ->
        new_state =
          if Map.has_key?(state, path) do
            Map.update(state, path, 0, fn value -> value + 1 end)
          else
            Map.put(state, path, 1)
          end

        send(sender, {:response, new_state})

        listen_loop(new_state)

      {sender, :get_count, path} ->
        if Map.has_key?(state, path) do
          send(sender, {:response, Map.get(state, path)})
        end

        listen_loop(state)

      {sender, :get_counts} ->
        send(sender, {:response, state})

        listen_loop(state)
    end
  end
end
