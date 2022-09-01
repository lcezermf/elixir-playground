defmodule Servy.Handler do
  @moduledoc """
  Handler request
  """

  import Servy.Plugins, only: [rewrite_path: 1, log: 1, track: 1]
  import Servy.Parser, only: [parse: 1]
  import Servy.FileHandler, only: [handle_file: 2]

  alias Servy.Request
  alias Servy.BearController
  alias Servy.VideoCam

  def handle(request) do
    request
    |> parse()
    |> rewrite_path()
    |> route()
    # |> emojify()
    |> log()
    |> track()
    |> put_content_length()
    |> format_response()
  end

  def route(%Request{method: "GET", path: "/wildthings"} = request) do
    %{request | status: 200, resp_body: "Bears, Lions, Tigers"}
  end

  def route(%Request{method: "GET", path: "/bears"} = request) do
    BearController.index(request)
  end

  def route(%Request{method: "GET", path: "/api/bears"} = request) do
    Servy.API.BearController.index(request)
  end

  def route(%Request{method: "POST", path: "/api/bears"} = request) do
    Servy.API.BearController.create(request, request.params)
  end

  def route(%Request{method: "GET", path: "/bears/" <> id} = request) do
    params = Map.put(request.params, "id", id)
    BearController.show(request, params)
  end

  def route(%Request{method: "GET", path: "/snapshots"} = conv) do
    parent = self()

    spawn(fn -> send(parent, {:result, VideoCam.get_snapshot("cam-1")}) end)
    spawn(fn -> send(parent, {:result, VideoCam.get_snapshot("cam-2")}) end)
    spawn(fn -> send(parent, {:result, VideoCam.get_snapshot("cam-3")}) end)

    snapshot_1 =
      receive do
        {:result, filename} -> filename
      end

    snapshot_2 =
      receive do
        {:result, filename} -> filename
      end

    snapshot_3 =
      receive do
        {:result, filename} -> filename
      end

    snapshots = [snapshot_1, snapshot_2, snapshot_3]

    %{conv | status: 200, resp_body: inspect(snapshots)}
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
    BearController.create(request, request.params)
  end

  def route(%Request{method: "DELETE", path: "/bears/" <> id} = request) do
    params = Map.put(request.params, "id", id)
    BearController.delete(request, params)
  end

  def route(%Request{path: path} = request) do
    %{request | status: 404, resp_body: "No #{path} here!"}
  end

  def emojify(%Request{status: 200, resp_body: resp_body} = request) do
    %{request | resp_body: "🎉 #{resp_body} 🎉"}
  end

  def emojify(%Request{} = request), do: request

  def put_content_length(request) do
    len = byte_size(request.resp_body)
    headers = Map.put(request.resp_headers, "Content-Length", len)

    %{request | resp_headers: headers}
  end

  def format_response(%Request{} = request) do
    """
    HTTP/1.1 #{Request.full_status(request)}\r
    Content-Type: #{request.resp_headers["Content-Type"]}\r
    Content-Length: #{request.resp_headers["Content-Length"]}\r
    \r
    #{request.resp_body}
    """
  end
end
