defmodule GenericServerProcess do
  def start(callback_module) do
    spawn(fn ->
      initial_state = callback_module.init
      loop(callback_module, initial_state)
    end)
  end

  def loop(callback_module, current_state) do
    receive do
      {request, caller} ->
        {response, new_state} = callback_module.handle_call(request, current_state)
        send(caller, {:response, response})

        loop(callback_module, new_state)
    end
  end

  def call(pid, request) do
    send(pid, {request, self})

    receive do
      {:response, response} -> response
    end
  end
end

defmodule KeyValueStore do
  def start do
    GenericServerProcess.start(KeyValueStore)
  end

  def put(pid, key, value) do
    GenericServerProcess.call(pid, {:put, key, value})
  end

  def get(pid, key) do
    GenericServerProcess.call(pid, {:get, key})
  end

  def init do
    Map.new()
  end

  def handle_call({:put, key, value}, state) do
    {:ok, Map.put(state, key, value)}
  end

  def handle_call({:get, key}, state) do
    {Map.get(state, key), state}
  end
end
