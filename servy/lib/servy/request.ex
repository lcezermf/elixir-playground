defmodule Servy.Request do
  defstruct method: "",
            path: "",
            resp_body: "",
            status: nil,
            params: %{},
            headers: %{},
            resp_headers: %{"Content-Type" => "text/html"}

  @spec full_status(atom | %{:status => any, optional(any) => any}) :: nonempty_binary
  def full_status(request) do
    "#{request.status} #{status_reason(request.status)}"
  end

  defp status_reason(code) do
    %{
      200 => "OK",
      201 => "Created",
      401 => "Unauthorized",
      403 => "Forbidden",
      404 => "Not Found",
      500 => "Internal Server Error"
    }[code]
  end
end
