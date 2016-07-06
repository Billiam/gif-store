# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :giftrap,
  ecto_repos: [Giftrap.Repo]

# Configures the endpoint
config :giftrap, Giftrap.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "0SMnYEMKtjPvdvZpEyLlRYB5gpIHNpJ2na9wQ3caWbizuauqEcX92rWeDCMsdx2s",
  render_errors: [view: Giftrap.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Giftrap.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
