
defmodule HttpServerTest do
  use ExUnit.Case

  alias Servy.HttpServer

  test "accepts a request on a socket and sends back a response" do
    spawn(HttpServer, :start, [4001])

    parent = self()

    spawn(fn -> send(parent, {:result, HTTPoison.get("http://localhost:4001/wildthings")}) end)
    spawn(fn -> send(parent, {:result, HTTPoison.get("http://localhost:4001/wildthings")}) end)
    spawn(fn -> send(parent, {:result, HTTPoison.get("http://localhost:4001/wildthings")}) end)
    spawn(fn -> send(parent, {:result, HTTPoison.get("http://localhost:4001/wildthings")}) end)
    spawn(fn -> send(parent, {:result, HTTPoison.get("http://localhost:4001/wildthings")}) end)

    for _ <- 1..5 do
      receive do
        {:result, {:ok, response}} ->
          assert response.status_code == 200
          assert response.body == "Bears, Lions, Tigers"
      end
    end

    # {:ok, response} = HTTPoison.get "http://localhost:4001/wildthings"

    # assert response.status_code == 200
    # assert response.body == "Bears, Lions, Tigers"
  end
end
