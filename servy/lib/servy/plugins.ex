defmodule Servy.Plugins do
  require Logger

  alias Servy.Request

  def rewrite_path(%Request{path: "/wildlife"} = request) do
    %{request | path: "/wildthings"}
  end

  def rewrite_path(%Request{path: path} = request) do
    regex = ~r{\/(?<thing>\w+)\?id=(?<id>\d+)}
    captures = Regex.named_captures(regex, path)
    rewrite_path_captures(request, captures)
  end

  def rewrite_path(%Request{} = request), do: request

  defp rewrite_path_captures(%Request{} = request, %{"thing" => thing, "id" => id}) do
    %{request | path: "/#{thing}/#{id}"}
  end

  defp rewrite_path_captures(%Request{} = request, nil), do: request

  def log(%Request{} = request) do
    if Mix.env() == :dev do
      log(request, request.status)
    end

    request
  end

  def log(%Request{} = request, status) when status in [200, 201] do
    Logger.info(request)

    request
  end

  def log(%Request{} = request, 403) do
    Logger.warn(request)

    request
  end

  def log(%Request{} = request, 404) do
    Logger.warn(request)

    request
  end

  def log(%Request{} = request, 500) do
    Logger.error(request)

    request
  end

  def track(%Request{status: 404, path: path} = request) do
    if Mix.env() != :test do
      IO.puts("Warning: #{path} is not here")
    end

    request
  end

  def track(%Request{} = request), do: request
end
