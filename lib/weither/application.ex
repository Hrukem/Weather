defmodule Weither.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    HTTPoison.start

    children = [
      # Start the Ecto repository
      Weither.Repo,
      # Start the Telemetry supervisor
      WeitherWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Weither.PubSub},
      # Start the Endpoint (http/https)
      WeitherWeb.Endpoint
      # Start a worker by calling: Weither.Worker.start_link(arg)
      # {Weither.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Weither.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    WeitherWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
