defmodule Servy.Plugins do
  require Logger

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

  def log(%{status: 200} = request) do
    Logger.info(request)

    request
  end

  def log(%{status: 403} = request) do
    Logger.warn(request)

    request
  end

  def log(%{status: 404} = request) do
    Logger.error(request)

    request
  end

  def log(%{status: 500} = request) do
    Logger.error(request)

    request
  end

  def log(request), do: request

  def track(%{status: 404, path: path} = request) do
    IO.puts("Warning: #{path} is not here")

    request
  end

  def track(request), do: request
end
