defmodule FamilyForeverPhoenixWeb.Services.GiphyService do
  alias FamilyForeverPhoenixWeb.Services.FetcherService

  @fetcher Application.get_env(:family_forever_phoenix, :fetcher, FetcherService)

  defp giphy_api_endpoint(tag) do
    "https://api.giphy.com/v1/gifs/random?api_key=#{System.get_env("GIPHY_API_KEY")}&tag=#{
      URI.encode(tag)
    }&rating=G"
  end

  defp return_gif_link(%{body: %{"data" => %{"images" => %{"fixed_width" => %{"url" => url}}}}}),
    do: url

  defp return_gif_link(_), do: "https://media.giphy.com/media/S5JSwmQYHOGMo/giphy.gif"

  def random_gif(query) do
    @fetcher.get(giphy_api_endpoint(query))
    |> return_gif_link
  end
end
