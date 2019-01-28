defmodule MyServer do
  @doc """
  pid = MyServer.start()
  MyServer.run_async(pid, "my query 1")
  MyServer.run_async(pid, "my query 2")
  MyServer.run_async(pid, "my query 3")
  MyServer.get_result()
  MyServer.get_result()
  MyServer.get_result()
  """
  def start do
    spawn(fn ->
      connection = :rand.uniform(1000)
      loop(connection)
    end)
  end

  def run_async(server_pid, query_def) do
    send(server_pid, {:run_query, self(), query_def})
  end

  def get_result do
    receive do
      {:query_result, result} -> result
    after
      5000 -> {:error, :timeout}
    end
  end

  defp loop(connection) do
    receive do
      {:run_query, caller, query_def} ->
        send(caller, {:query_result, run_query(connection, query_def)})
    end

    loop(connection)
  end

  defp run_query(connection, query_def) do
    :timer.sleep(2000)
    "Connection: #{connection} - Query: #{query_def} result"
  end
end
