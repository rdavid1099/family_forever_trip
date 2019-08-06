Mox.defmock(FamilyForeverPhoenixWeb.Services.FetcherServiceMock,
  for: FamilyForeverPhoenixWeb.Services.FetcherService
)

ExUnit.start()
Ecto.Adapters.SQL.Sandbox.mode(FamilyForeverPhoenix.Repo, :manual)
