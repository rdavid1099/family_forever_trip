defmodule FamilyForeverPhoenixWeb.Api.Slack.Slash.CountdownController do
  use FamilyForeverPhoenixWeb, :controller

  def create(conn, params) do
    render(conn, "create.json", params: params)
  end
end
