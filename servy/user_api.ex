defmodule UserAPI do
  @url "https://jsonplaceholder.typicode.com/users/"

  def run(user_id) do
    case HTTPoison.get(@url <> user_id) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        city =
          body
          |> Poison.Parser.parse!(%{})
          |> Kernel.get_in(["address", "city"])

        {:ok, city}
      {:ok, %HTTPoison.Response{status_code: _status, body: body}} ->
        message =
          body
          |> Poison.Parser.parse!(%{})
          |> get_in(["message"])

        {:error, message}
      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, reason}
      _ ->
        IO.inspect("Default")
    end
  end
end
