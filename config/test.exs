import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :hunger_games, HungerGames.Repo,
  pool: Ecto.Adapters.SQL.Sandbox,
  database: "hunger_games_test"

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :hunger_games, HungerGamesWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  server: false

# In test we don't send emails.
config :hunger_games, HungerGames.Mailer, adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime

config :hunger_games, Oban, queues: false, plugins: false
