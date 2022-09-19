defmodule Servy.KickStarter do
  use GenServer

  def start do
    IO.puts("Starting kickstarter")
    GenServer.start(__MODULE__, :ok, name: __MODULE__)
  end

  def get_server do
    GenServer.call(__MODULE__, :get_server)
  end

  def init(:ok) do
    Process.flag(:trap_exit, true)
    server_pid = start_server()
    {:ok, server_pid}
  end

  # Server

  def handle_call(:get_server, _from, state) do
    {:reply, Process.whereis(:http_server), state}
  end

  def handle_info({:EXIT, _pid, reason}, _state) do
    IO.puts("Exiting: #{reason}")
    server_pid = start_server()
    {:noreply, server_pid}
  end

  defp start_server do
    IO.puts("Starting http server")
    server_pid = spawn_link(Servy.HttpServer, :start, [4000])
    Process.register(server_pid, :http_server)
    server_pid
  end
end
