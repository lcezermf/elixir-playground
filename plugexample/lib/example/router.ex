defmodule Example.Router do
  use Plug.Router

  plug(:match)
  plug(:dispatch)

  get("/", do: send_resp(conn, 200, "Welcome"))
  get(_, do: send_resp(conn, 404, "Ops! Some shit happen!"))
end
