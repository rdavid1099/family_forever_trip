defmodule FamilyForeverPhoenixWeb.Services.PokemonService do
  alias FamilyForeverPhoenixWeb.Services.FetcherService

  @pokemon_color %{
      "black" => "#000000",
      "blue" => "#3A93FF",
      "brown" => "#DB9500",
      "gray" => "#C1C1C1",
      "green" => "#08D115",
      "pink" => "#FF5BEB",
      "purple" => "#AF16FC",
      "red" => "#F91616",
      "white" => "#FFFFFF",
      "yellow" => "#F2E604"
    }

  defp pokeapi_endpoint(query) do
    "https://pokeapi.co/api/v2/pokemon/#{query}"
  end

  defp return_data(%{status_code: 404}), do: %{error: true, status_code: 404}

  defp return_data(%{status_code: 200, body: %{"species" => %{"url" => species_url}} = response}) do
    FetcherService.get(species_url)
      |> return_data
      |> Map.merge(response)
  end

  defp return_data(%{status_code: 200, body: body}), do: body

  defp stringify_types(types) do
    Enum.reduce(types, [], &([String.capitalize(&1["type"]["name"]) | &2]))
      |> Enum.reverse
      |> Enum.join("/")
  end

  defp latest_flavor_text([%{"language" => %{"name" => name}, "flavor_text" => flavor_text} | tail], lang_name)
    when name == lang_name, do: flavor_text

  defp latest_flavor_text([head | tail], lang_name) do
    latest_flavor_text(tail, lang_name)
  end

  def format_response(raw_response) do
    # [name, types, flavor_text, color, height, weight, front, back]
    [
      String.capitalize(raw_response["name"]),
      stringify_types(raw_response["types"]),
      latest_flavor_text(raw_response["flavor_text_entries"], "en"),
      @pokemon_color[raw_response["color"]["name"]],
      "#{raw_response["height"] / 10.0} Meters",
      "#{raw_response["weight"] / 10.0} Kilograms",
      raw_response["sprites"]["front_default"],
      raw_response["sprites"]["back_default"]
    ]
  end

  def call(query) do
    FetcherService.get(pokeapi_endpoint(query))
      |> return_data
  end
end

# FamilyForeverPhoenixWeb.Modules.Mildred.json_slash_response(%{"respond_to" => "pokedex", "channel_name" => "stuff", "text" => "charmand"})
