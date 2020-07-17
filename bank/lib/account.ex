defmodule Account do
  use GenServer

  # Client API

  def start_link do
    GenServer.start_link(__MODULE__, :ok)
  end

  def get_balance(pid) do
    GenServer.call(pid, :get_balance)
  end

  def deposit(pid, value) do
    GenServer.cast(pid, {:deposit, value})
  end

  # Server API

  def init(:ok) do
    {:ok, %{balance: 0}}
  end

  def handle_call(:get_balance, _from, state) do
    {:reply, Map.get(state, :balance), state}
  end

  def handle_cast({:deposit, value}, state) do
    current_balance = Map.get(state, :balance)

    {:noreply, Map.put(state, :balance, current_balance + value)}
  end
end
