
defmodule HttpServerTest do
  use ExUnit.Case

  alias Servy.HttpServer

  test "accepts a request on a socket and sends back a response" do
    spawn(HttpServer, :start, [4001])

    1..5
    |> Enum.map(fn(_) -> Task.async(fn -> HTTPoison.get("http://localhost:4001/wildthings") end) end)
    |> Enum.map(&Task.await/1)
    |> Enum.map(&assert_response/1)
  end

  defp assert_response({:ok, response}) do
    assert response.status_code == 200
    assert response.body == "Bears, Lions, Tigers"
  end
end
