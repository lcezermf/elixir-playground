defmodule Servy.PledgeServer do
  def listen_loop(state) do
    IO.puts("Waiting...")

    receive do
      {:create_pledge, name, amount} ->
        {:ok, id} = send_pledge_to_service(name, amount)
        new_state = [{name, amount}, state]
        IO.puts("#{name} pledge #{amount}")
        IO.puts("New state is #{inspect(new_state)}")
        listen_loop(new_state)
      {sender, :recent_pledges} ->
        send(sender, {:response, state})
        listen_loop(state)
    end
  end

  # def create_pledge(name, amount) do
  #   {:ok, id} = send_pledge_to_service(name, amount)
  # end
  #
  # def recent_pledges do
  #   []
  # end

  def send_pledge_to_service(_name, _amount) do
    {:ok, "pledge-#{:rand.uniform(1_000)}"}
  end
end
