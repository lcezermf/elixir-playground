defmodule Servy.Handler do
  def handle(request) do
    request
    |> parse()
    |> route()
    |> format_response()
  end

  def parse(request) do
    [method, path, _] =
      request
      |> String.split("\n")
      |> Kernel.hd()
      |> String.split(" ")

    %{method: method, path: path, resp_body: ""}
  end
  def route(request) do

    conv = %{method: "GET", path: "/wildthings", resp_body: "One, Two, Three"}
  end

  def format_response(conv) do
    """
    HTTP/1.1 200 OK
    Content-Type: text/html
    Content-Length: 20

    One, Two, Three
    """
  end
end

request = """
GET /wildthings HTTP/1.1
Host: example.com
User-Agent: ExampleBrowser/1.0
Accept: */*

"""

IO.puts(Servy.Handler.handle(request))
