# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :weither,
  ecto_repos: [Weither.Repo]

# Configures the endpoint
config :weither, WeitherWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "MrW8qsRA/Z1INsYLujWEG6LdDE7Tp4P5tU/n7CUijPPtfenvYrnxH4aYLm2Z+B5S",
  render_errors: [view: WeitherWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Weither.PubSub,
  live_view: [signing_salt: "gDf9iV5k"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
