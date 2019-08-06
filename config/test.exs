use Mix.Config

# Configure your database
config :family_forever_phoenix, FamilyForeverPhoenix.Repo,
  username: "postgres",
  password: "postgres",
  database: "family_forever_phoenix_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :family_forever_phoenix, FamilyForeverPhoenixWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

config :family_forever_phoenix, :fetcher, FamilyForeverPhoenixWeb.Services.FetcherServiceMock
