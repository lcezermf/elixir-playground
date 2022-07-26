defmodule MinOtp.Account do
  use GenServer

  def init(account) do
    {:ok, account}
  end

  def start_link({name, balance}) do
    GenServer.start_link(__MODULE__, {name, balance}, name: name)
  end

  def handle_call(:info_account, _from, state) do
    {:reply, state, state}
  end

  def handle_cast({:send_money, value}, state) do
    {name, balance} = state

    {:noreply, {name, balance + value}}
  end

  # Public

  def info(name), do: GenServer.call(name, :info_account)

  def send_money(name, balance), do: GenServer.cast(name, {:send_money, balance})
end

# {:ok, pid} = MinOtp.Account.start_link({:cezer, 1000})
# GenServer.call(pid, :info_account)
