defmodule Servy.PledgeServer do
  @name :pledge_server

  # Client/API functions

  def start do
    IO.puts("Starting...")
    pid = spawn(__MODULE__, :listen_loop, [[]])
    Process.register(pid, @name)
    pid
  end

  def create_pledge(name, amount) do
    send(@name, {self(), :create_pledge, name, amount})

    receive do
      {:response, status} -> status
    end
  end

  def recent_pledges do
    send(@name, {self(), :recent_pledges})

    receive do
      {:response, pleges} -> pleges
    end
  end

  # Server functions

  def listen_loop(state) do
    receive do
      {sender, :create_pledge, name, amount} ->
        {:ok, id} = send_pledge_to_service(name, amount)
        new_state = [{name, amount} | Enum.take(state, 2)]
        send(sender, {:response, id})
        listen_loop(new_state)
      {sender, :recent_pledges} ->
        send(sender, {:response, state})
        listen_loop(state)
    end
  end

  def send_pledge_to_service(_name, _amount) do
    {:ok, "pledge-#{:rand.uniform(1_000)}"}
  end
end
