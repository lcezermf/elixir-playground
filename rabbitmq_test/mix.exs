defmodule RabbitmqTest.MixProject do
  use Mix.Project

  def project do
    [
      app: :rabbitmq_test,
      version: "0.1.0",
      elixir: "~> 1.8",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [applications: [:amqp]]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:amqp, "~> 1.0"}
    ]
  end
end
