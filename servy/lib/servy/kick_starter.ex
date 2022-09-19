defmodule Servy.KickStarter do
  use GenServer

  def start do
    IO.puts("Starting kickstarter")
    GenServer.start(__MODULE__, :ok, name: __MODULE__)
  end

  def init(:ok) do
    Process.flag(:trap_exit, true)
    IO.puts("Starting http server")
    server_pid = spawn(Servy.HttpServer, :start, [4000])
    Process.link(server_pid)
    Process.register(server_pid, :http_server)
    {:ok, server_pid}
  end

  def handle_info({:EXIT, _pid, reason}, _state) do
    IO.puts("Exiting: #{reason}")
    IO.puts("Starting http server")
    server_pid = spawn(Servy.HttpServer, :start, [4000])
    Process.link(server_pid)
    Process.register(server_pid, :http_server)
    {:noreply, server_pid}
  end
end
