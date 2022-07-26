defmodule MinOtp.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Starts a worker by calling: MinOtp.Worker.start_link(arg)
      # {MinOtp.Worker, arg}
      create_account({:cezercezer, 1000}),
      create_account({:cezer, 2000}),
      create_account({:luiz, 1500})
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: MinOtp.Supervisor]
    Supervisor.start_link(children, opts)
  end

  defp create_account({name, balance}) do
    %{
      id: name,
      start: {MinOtp.Account, :start_link, [{name, balance}]}
    }
  end
end
