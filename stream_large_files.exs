defmodule HTTPStream do
  def get(url) do
    Stream.resource(
      start_fun(),
      next_fun(),
      end_fun()
    )
  end

  def start_fun do
    fn ->
      HTTPoison.get!(
        url, %{},
        [stream_to: self(), async: :once]
      )
    end
  end

  def next_fun do
    fn %HTTPoison.AsyncResponse{id: id} = resp ->
      receive do
        %HTTPoison.AsyncStatus{id: ^id, code: code} ->
          IO.inspect(code, label: "Status code: ")
          {:halt, resp}
      after
        5_000 -> raise "timeout"
      end
    end
  end

  def end_fun do
    :ok
  end
end
