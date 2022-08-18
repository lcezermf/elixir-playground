defmodule Servy.FileHandler do
  def handle_file({:ok, content}, request), do: %{request | status: 200, resp_body: content}

  def handle_file({:error, :enoent}, request),
    do: %{request | status: 404, resp_body: "File not found!"}

  def handle_file({:error, reason}, request),
    do: %{request | status: 500, resp_body: "File error: #{reason}"}
end
