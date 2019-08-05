defmodule FamilyForeverPhoenixWeb.Services.FetcherService do
  def get(url) do
    case HTTPoison.get url do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} -> %{status_code: 200, body: Poison.decode!(body)}
      {:ok, %HTTPoison.Response{status_code: status_code, body: body}} -> %{status_code: status_code, body: body}
      {:error, %HTTPoison.Error{reason: reason}} -> %{reason: reason}
    end
  end
end
