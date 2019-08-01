defmodule FamilyForeverPhoenix.Repo do
  use Ecto.Repo,
    otp_app: :family_forever_phoenix,
    adapter: Ecto.Adapters.Postgres
end
