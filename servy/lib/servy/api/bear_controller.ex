defmodule Servy.API.BearController do
  def index(conn) do
    bears =
      Servy.Wildthings.list_bears()
      |> Poison.encode!()

    conn = put_resp_content_type(conn, "application/json")

    %{conn | status: 200, resp_body: bears}
  end

  defp put_resp_content_type(conn, type) do
    headers = Map.put(conn.resp_headers, "Content-Type", type)

    %{conn | resp_headers: headers}
  end
end
