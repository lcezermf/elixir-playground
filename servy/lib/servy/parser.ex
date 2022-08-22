defmodule Servy.Parser do
  alias Servy.Request

  def parse(request) do
    [top, query_string] = String.split(request, "\n\n")
    [request_line | _header_lines] = String.split(top, "\n")
    [method, path, _] = String.split(request_line, " ")
    params = parse_query_string(query_string)

    %Request{method: method, path: path, params: params}
  end

  defp parse_query_string(query_string), do: query_string |> String.trim() |> URI.decode_query()
end
