defmodule URLShortner do
  def start do
    spawn(__MODULE__, :loop, [%{}])
  end

  def loop(state) do
    receive do
      {:stop, caller} -> send caller, "Shutdown."
      {:shorten, url, caller} ->
        url_md5 = short_url(url)
        new_state = Map.put(state, url_md5, url)
        send caller, url_md5
        loop(new_state)
      {:get, url_md5, caller} ->
        send caller, Map.get(state, url_md5)
        loop(state)
      {:flush} -> loop([%{}])
      _ -> loop(state)
    end
  end

  defp short_url(url) do
    :crypto.hash(:md5, url) |> Base.encode16()
  end
end
