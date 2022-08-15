defmodule Servy.Handler do
  def handle(request) do
    request
    |> parse()
    |> log()
    |> route()
    |> format_response()
  end

  def parse(request) do
    [method, path, _] =
      request
      |> String.split("\n")
      |> Kernel.hd()
      |> String.split(" ")

    %{method: method, path: path, resp_body: "", status: nil}
  end

  def log(request), do: IO.inspect(request)

  def route(request) do
    route(request, request.method, request.path)
  end

  def route(request, "GET", "/wildthings") do
    %{request | status: 200, resp_body: "Bears, Lions, Tigers"}
  end

  def route(request, "GET", "/bears") do
    %{request | status: 200, resp_body: "Bear #1, Bear #2, Bear #3"}
  end

  def route(request, "GET", "/bears/" <> id) do
    %{request | status: 200, resp_body: "Bear ID #{id}"}
  end

  def route(request, "DELETE", "/bears/" <> id) do
    %{request | status: 200, resp_body: "Bear ID #{id} deleted"}
  end

  def route(request, _method, path) do
    %{request | status: 404, resp_body: "No #{path} here!"}
  end

  def format_response(request) do
    """
    HTTP/1.1 #{request.status} #{status_reason(request.status)}
    Content-Type: text/html
    Content-Length: #{String.length(request.resp_body)}

    #{request.resp_body}
    ---

    """
  end

  defp status_reason(code) do
    %{
      200 => "OK",
      201 => "Created",
      401 => "Unauthorized",
      403 => "Forbidden",
      404 => "Not found",
      500 => "Internal Server Error"
    }[code]
  end
end

request = """
GET /wildthings HTTP/1.1
Host: example.com
User-Agent: ExampleBrowser/1.0
Accept: */*

"""

IO.puts(Servy.Handler.handle(request))

request = """
GET /bears/1 HTTP/1.1
Host: example.com
User-Agent: ExampleBrowser/1.0
Accept: */*

"""

IO.puts(Servy.Handler.handle(request))

request = """
GET /bigfoot HTTP/1.1
Host: example.com
User-Agent: ExampleBrowser/1.0
Accept: */*

"""

IO.puts(Servy.Handler.handle(request))

request = """
DELETE /bears/25 HTTP/1.1
Host: example.com
User-Agent: ExampleBrowser/1.0
Accept: */*

"""

IO.puts(Servy.Handler.handle(request))
