defmodule Weither.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application
  def start(_type, _args) do
    config = read_environment_variables()
    cache_forecast_init()

    children = [
      # Start the Ecto repository
      {
        Weither.Repo,
        username: config.username_repo,
        password: config.password_repo,
        database: config.database_repo,
        hostname: config.hostname_repo,
        pool_size: config.pool_size
      },
      # Start the Telemetry supervisor
      WeitherWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Weither.PubSub},
      # Start the Endpoint (http/https)
      {
        WeitherWeb.Endpoint,
        http: [port: config.port], 
        secret_key_base: config.secret_key_base
      },
      # Start a worker by calling: Weither.Worker.start_link(arg)
      # {Weither.Worker, arg}
      Weither.Scheduler
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

  def cache_forecast_init() do
    :ets.new(:forecast_caching, [:set, :public, :named_table])
    Weither.Cache.Forecast.init()
  end
  
  # reading environment variables
  defp read_environment_variables() do
    Vapor.load!([%Vapor.Provider.Dotenv{}])

    providers = 
      %Vapor.Provider.Env{
        bindings: [
          {:port, "PORT", map: &String.to_integer/1},
          {:secret_key_base, "SECRET_KEY_BASE"},
          {:secret_weather_api, "SECRET_WEATHER_API"},
          {:username_repo, "USERNAME_REPO"},
          {:password_repo, "PASSWORD_REPO"},
          {:database_repo, "DATABASE_REPO"},
#          {:hostname_repo, "HOSTNAME_REPO", map: &String.to_integer/1},
          {:hostname_repo, "HOSTNAME_REPO"},
          {:pool_size, "POOL_SIZE", map: &String.to_integer/1}
        ]
      }

    config = Vapor.load!(providers)

    Application.put_env(
      :weither, 
      :secret_weather_api,
      config.secret_weather_api
    )

    config
  end
end
