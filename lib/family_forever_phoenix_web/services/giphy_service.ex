defmodule FamilyForeverPhoenixWeb.Services.GiphyService do
  defp giphy_api_endpoint(tag) do
    "https://api.giphy.com/v1/gifs/random?api_key=#{System.get_env("GIPHY_API_KEY")}&tag=#{URI.encode(tag)}&rating=G"
  end

  defp return_gif_link(body) do
    %{"data" => %{"images" => %{"fixed_width" => %{"url" => url}}}} = Poison.decode! body
    url
  end

  def random_gif(query) do
    case HTTPoison.get giphy_api_endpoint(query)do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} -> return_gif_link(body)
      {:error, %HTTPoison.Error{reason: _}} -> "https://media.giphy.com/media/S5JSwmQYHOGMo/giphy.gif"
    end
  end
end
