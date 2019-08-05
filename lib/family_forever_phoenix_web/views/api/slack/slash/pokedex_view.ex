defmodule FamilyForeverPhoenixWeb.Api.Slack.Slash.PokedexView do
  use FamilyForeverPhoenixWeb, :view

  alias FamilyForeverPhoenixWeb.Modules.Mildred

  def render("create.json", %{params: params}) do
    params
      |> Map.merge(%{"respond_to" => "pokedex"})
      |> Mildred.json_slash_response
  end
end
