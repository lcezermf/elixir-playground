defmodule URLShortenerGenServer do
  use GenServer

  def start_link(name, opts \\ []), do: GenServer.start_link(__MODULE__, :ok, opts ++ [name: name])

  def stop(name), do: GenServer.cast(name, :stop)
  def shorten(name, url), do: GenServer.call(name, {:shorten, url})
  def get(name, url_md5), do: GenServer.call(name, {:get, url_md5})

  # Server callbacks
  def init(:ok), do: {:ok, %{}}
  def handle_cast(stop, state), do: {:stop, :normal, state}

  def handle_call({:shorten, url}, _from, state) do
    url_md5 = short_url(url)
    {:reply, url_md5, Map.put(state, url_md5, url)}
  end

  def handle_call({:get, url_md5}, _from, state) do
    {:reply, Map.get(state, url_md5), state}
  end

  defp short_url(url), do: :crypto.hash(:md5, url) |> Base.encode16(case: :lower)
end
