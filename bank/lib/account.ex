defmodule Account do
  use GenServer

  # Client API

  def start_link do
    GenServer.start_link(__MODULE__, :ok)
  end

  def get_balance(pid) do
    GenServer.call(pid, :get_balance)
  end

  def deposit(pid, amount) do
    GenServer.cast(pid, {:deposit, amount})
  end

  def withdraw(pid, amount) do
    GenServer.cast(pid, {:withdraw, amount})
  end

  # Server API

  def init(:ok) do
    {:ok, %{balance: 0}}
  end

  def handle_call(:get_balance, _from, state) do
    {:reply, Map.get(state, :balance), state}
  end

  def handle_cast({:deposit, amount}, state) do
    update_balance = fn balance, amount -> balance + amount end

    {:noreply, change_balance(state, amount, update_balance)}
  end

  def handle_cast({:withdraw, amount}, state) do
    {:noreply, change_balance(state, amount, &(&1 - &2))}
  end

  defp change_balance(state, amount, fn_update_balance) do
    {_amount, updated_balance} =
      Map.get_and_update(state, :balance, fn balance ->
        {balance, fn_update_balance.(balance, amount)}
      end)

    updated_balance
  end
end
