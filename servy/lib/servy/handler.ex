defmodule Servy.Handler do
  def handle(request) do
    request
    |> parse()
    |> rewrite_path()
    |> route()
    |> emojify()
    |> log()
    |> track()
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

  def rewrite_path(%{path: "/wildlife"} = request) do
    %{request | path: "/wildthings"}
  end

  def rewrite_path(%{path: path} = request) do
    regex = ~r{\/(?<thing>\w+)\?id=(?<id>\d+)}
    captures = Regex.named_captures(regex, path)
    rewrite_path_captures(request, captures)
  end

  def rewrite_path(request), do: request

  defp rewrite_path_captures(request, %{"thing" => thing, "id" => id}) do
    %{request | path: "/#{thing}/#{id}"}
  end

  defp rewrite_path_captures(conv, nil), do: conv

  def log(request), do: IO.inspect(request)

  def route(%{method: "GET", path: "/wildthings"} = request) do
    %{request | status: 200, resp_body: "Bears, Lions, Tigers"}
  end

  def route(%{method: "GET", path: "/bears"} = request) do
    %{request | status: 200, resp_body: "Bear #1, Bear #2, Bear #3"}
  end

  def route(%{method: "GET", path: "/bears/" <> id} = request) do
    %{request | status: 200, resp_body: "Bear ID #{id}"}
  end

  def route(%{method: "DELETE", path: "/bears/" <> _id} = request) do
    %{ request | status: 403, resp_body: "Deleting a bear is forbidden!"}
  end

  def route(%{path: path} = request) do
    %{request | status: 404, resp_body: "No #{path} here!"}
  end

  def emojify(%{status: 200, resp_body: resp_body} = request) do
    %{request | resp_body: "🎉 #{resp_body} 🎉"}
  end

  def emojify(request), do: request

  def track(%{status: 404, path: path} = request) do
    IO.puts("Warning: #{path} is not here")

    request
  end

  def track(request), do: request

  def format_response(request) do
    """
    HTTP/1.1 #{request.status} #{status_reason(request.status)}
    Content-Type: text/html
    Content-Length: #{byte_size(request.resp_body)}

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

request = """
GET /wildlife HTTP/1.1
Host: example.com
User-Agent: ExampleBrowser/1.0
Accept: */*

"""

IO.puts(Servy.Handler.handle(request))

request = """
GET /bears?id=7 HTTP/1.1
Host: example.com
User-Agent: ExampleBrowser/1.0
Accept: */*

"""

IO.puts(Servy.Handler.handle(request))
