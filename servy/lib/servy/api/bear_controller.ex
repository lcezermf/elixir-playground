defmodule Servy.API.BearController do

  def index(conn) do
    bears =
      Servy.Wildthings.list_bears()
      |> Poison.encode!()

    %{conn | status: 200, resp_body: bears, resp_content_type: "application/json"}
  end

end
