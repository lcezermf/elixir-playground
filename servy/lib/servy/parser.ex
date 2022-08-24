defmodule Servy.Parser do
  alias Servy.Request

  def parse(request) do
    [top, query_string] = String.split(request, "\n\n")
    [request_line | header_lines] = String.split(top, "\n")
    [method, path, _] = String.split(request_line, " ")
    headers = parse_headers(header_lines, %{})
    params = parse_query_string(headers["Content-Type"], query_string)

    %Request{method: method, path: path, params: params, headers: headers}
  end

  defp parse_headers([head | tail], accum_map) do
    [key, value] = String.split(head, ": ")
    accum_map = Map.put(accum_map, key, value)
    parse_headers(tail, accum_map)
  end

  defp parse_headers([], accum_map), do: accum_map

  defp parse_query_string("application/x-www-form-urlencoded", query_string),
    do: query_string |> String.trim() |> URI.decode_query()

  defp parse_query_string(_, _), do: %{}
end
