# defmodule Servy.GenServer do
#   def start(callback_module, initial_state, name) do
#     pid = spawn(__MODULE__, :listen_loop, [initial_state, callback_module])
#     Process.register(pid, name)
#     pid
#   end

#   def call(pid, message) do
#     send(pid, {:call, self(), message})

#     receive do
#       {:response, response} -> response
#     end
#   end

#   def cast(pid, message) do
#     send(pid, {:cast, message})
#   end

#   def listen_loop(state, callback_module) do
#     receive do
#       {:call, sender, message} when is_pid(sender) ->
#         {response, new_state} = callback_module.handle_call(message, state)
#         send(sender, {:response, response})
#         listen_loop(new_state, callback_module)

#       {:cast, message} ->
#         new_state = callback_module.handle_cast(message, state)
#         listen_loop(new_state, callback_module)

#         # unexpected ->
#         #   IO.puts("Weird stuff")
#         #   listen_loop(state)
#     end
#   end
# end

defmodule Servy.FourOhFourCounter do
  @name __MODULE__

  use GenServer

  # Client

  def start() do
    GenServer.start(__MODULE__, %{}, name: @name)
  end

  def bump_count(path) do
    GenServer.call(@name, {:bump_count, path})
  end

  def get_count(path) do
    GenServer.call(@name, {:get_count, path})
  end

  def get_counts do
    GenServer.call(@name, :get_counts)
  end

  def reset do
    GenServer.cast(@name, :reset)
  end

  # Server

  def init(init_arg) do
    {:ok, init_arg}
  end

  def handle_call(:get_counts, _from, state) do
    {:reply, state, state}
  end

  def handle_call({:get_count, path}, _from, state) do
    {:reply, Map.get(state, path, 0), state}
  end

  def handle_call({:bump_count, path}, _from, state) do
    new_state =
      if Map.has_key?(state, path) do
        Map.update(state, path, 0, fn value -> value + 1 end)
      else
        Map.put(state, path, 1)
      end

    {:reply, new_state, new_state}
  end

  def handle_cast(:reset, _state) do
    {:noreply, %{}}
  end
end
