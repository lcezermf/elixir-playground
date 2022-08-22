defmodule Servy.Handler do
  @moduledoc """
  Handler request
  """

  import Servy.Plugins, only: [rewrite_path: 1, log: 1, track: 1]
  import Servy.Parser, only: [parse: 1]
  import Servy.FileHandler, only: [handle_file: 2]

  alias Servy.Request

  def handle(request) do
    request
    |> parse()
    |> rewrite_path()
    |> route()
    # |> emojify()
    |> log()
    |> track()
    |> format_response()
  end

  def route(%Request{method: "GET", path: "/wildthings"} = request) do
    %{request | status: 200, resp_body: "Bears, Lions, Tigers"}
  end

  def route(%Request{method: "GET", path: "/bears"} = request) do
    %{request | status: 200, resp_body: "Bear #1, Bear #2, Bear #3"}
  end

  def route(%Request{method: "GET", path: "/bears/" <> id} = request) do
    %{request | status: 200, resp_body: "Bear ID #{id}"}
  end

  def route(%Request{method: "GET", path: "/" <> page} = request) do
    File.read("./pages/#{page}.html")
    |> handle_file(request)
  end

  def route(%Request{method: "GET", path: "/bears/new"} = request) do
    File.read("./pages/form.html")
    |> handle_file(request)
  end

  def route(%Request{method: "POST", path: "/bears"} = request) do
    %{request | status: 201, resp_body: "Created a #{request.params["type"]} bear named as #{request.params["name"]}"}
  end

  def route(%Request{method: "DELETE", path: "/bears/" <> _id} = request) do
    %{request | status: 403, resp_body: "Deleting a bear is forbidden!"}
  end

  def route(%Request{path: path} = request) do
    %{request | status: 404, resp_body: "No #{path} here!"}
  end

  def emojify(%Request{status: 200, resp_body: resp_body} = request) do
    %{request | resp_body: "🎉 #{resp_body} 🎉"}
  end

  def emojify(%Request{} = request), do: request

  def format_response(%Request{} = request) do
    """
    HTTP/1.1 #{Request.full_status(request)}
    Content-Type: text/html
    Content-Length: #{byte_size(request.resp_body)}

    #{request.resp_body}
    """
  end
end

# request = """
# GET /wildthings HTTP/1.1
# Host: example.com
# User-Agent: ExampleBrowser/1.0
# Accept: */*

# """

# IO.puts(Servy.Handler.handle(request))

# request = """
# GET /bears/1 HTTP/1.1
# Host: example.com
# User-Agent: ExampleBrowser/1.0
# Accept: */*

# """

# IO.puts(Servy.Handler.handle(request))

# request = """
# GET /bigfoot HTTP/1.1
# Host: example.com
# User-Agent: ExampleBrowser/1.0
# Accept: */*

# """

# IO.puts(Servy.Handler.handle(request))

# request = """
# DELETE /bears/25 HTTP/1.1
# Host: example.com
# User-Agent: ExampleBrowser/1.0
# Accept: */*

# """

# IO.puts(Servy.Handler.handle(request))

# request = """
# GET /wildlife HTTP/1.1
# Host: example.com
# User-Agent: ExampleBrowser/1.0
# Accept: */*

# """

# IO.puts(Servy.Handler.handle(request))

# request = """
# GET /bears?id=7 HTTP/1.1
# Host: example.com
# User-Agent: ExampleBrowser/1.0
# Accept: */*

# """

# IO.puts(Servy.Handler.handle(request))

# request = """
# GET /about HTTP/1.1
# Host: example.com
# User-Agent: ExampleBrowser/1.0
# Accept: */*

# """

# IO.puts(Servy.Handler.handle(request))

# request = """
# GET /faq HTTP/1.1
# Host: example.com
# User-Agent: ExampleBrowser/1.0
# Accept: */*

# """

# IO.puts(Servy.Handler.handle(request))

# request = """
# GET /bears/new HTTP/1.1
# Host: example.com
# User-Agent: ExampleBrowser/1.0
# Accept: */*

# """

# IO.puts(Servy.Handler.handle(request))


request = """
POST /bears HTTP/1.1
Host: example.com
User-Agent: ExampleBrowser/1.0
Accept: */*
Content-Type: application/x-www-form-urlencoded
Content-Length: 21

name=Baloo&type=Brown
"""

IO.puts(Servy.Handler.handle(request))
