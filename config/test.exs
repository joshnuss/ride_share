use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :ride_share, RideShare.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :ride_share, RideShare.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "ride_share_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
