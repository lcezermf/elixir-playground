defmodule Servy.API.BearController do
  def index(request) do
    bears =
      Servy.Wildthings.list_bears()
      |> Poison.encode!()

    request = put_resp_content_type(request, "application/json")

    %{request | status: 200, resp_body: bears}
  end

  def create(request, %{"name" => name, "type" => type}) do
    %{request | status: 201, resp_body: "Created a #{type} bear named #{name}!"}
  end

  defp put_resp_content_type(conn, type) do
    headers = Map.put(conn.resp_headers, "Content-Type", type)

    %{conn | resp_headers: headers}
  end
end
