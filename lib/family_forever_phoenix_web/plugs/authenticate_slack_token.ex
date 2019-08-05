defmodule FamilyForeverPhoenix.Plugs.AuthenticateSlackToken do
  import Plug.Conn

  def init(default), do: default

  def call(%Plug.Conn{params: %{"token" => token}} = conn, _default) do
    if token == System.get_env("SLACK_APP_TOKEN") do
      conn
    else
      conn |> halt()
    end
  end
end
