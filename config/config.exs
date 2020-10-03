# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :ex_21,
  ecto_repos: [Ex21.Repo]

# Configures the endpoint
config :ex_21, Ex21Web.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "iRQJmeGduta5aGdKzzoXiiASuHZYLXaNoIBGlAkdcxlJMbmYCSA2CSZhDkmzJ1aO",
  render_errors: [view: Ex21Web.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Ex21.PubSub,
  live_view: [signing_salt: "/gfZrZC/"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
