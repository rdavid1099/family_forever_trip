defmodule FamilyForeverPhoenixWeb.Modules.Mildred do
  alias FamilyForeverPhoenixWeb.Services.GiphyService
  alias FamilyForeverPhoenixWeb.Services.MessagingService
  alias FamilyForeverPhoenixWeb.Services.PokemonService

  @slash_commands [
    "countdown",
    "pokedex"
  ]

  @default_params %{
    "user_id" => "Deary",
    "response_type" => "in_channel"
  }

  defp sanitize_params_with_defaults(params) do
    Map.merge(@default_params, params)
  end

  def json_slash_response(%{"respond_to" => respond_to, "channel_name" => channel} = params)
  when respond_to in @slash_commands do
    sanitize_params_with_defaults(params)
      |> response(respond_to)
      |> Map.merge(%{
        channel: channel,
        response_type: params["response_type"],
        as_user: false,
        username: "Mildred"
      })
  end

  defp response(%{"user_id" => user_id}, "countdown") do
    custom_messages(user_id, "countdown", fn [greeting, time_left, ts, color] ->
      %{
        text: "#{greeting} Let's see how much time is left until our big trip!",
        attachments: [%{
          title: "It's The Final Countdown!",
          text: time_left,
          image_url: GiphyService.random_gif("super fun time"),
          ts: ts,
          color: color
        }]
      }
    end)
  end

  defp response(%{"text" => query}, "pokedex") do
    custom_messages(query, "pokedex", fn [name, types, flavor_text, color, height, weight, front, back] ->
      %{
        text: "Who's that Pokémon?! It's #{name}!",
        attachments: [%{
          title: "#{name}: #{types} Type Pokémon",
          title_link: "https://bulbapedia.bulbagarden.net/wiki/#{name}_(Pok%C3%A9mon)",
          text: flavor_text,
          color: color,
          fields: [%{
            title: "Height",
            value: height,
            short: true
          }, %{
            title: "Weight",
            value: weight,
            short: true
          }],
          image_url: front,
          footer_icon: back
        }]
      }
    end)
  end

  defp custom_messages(user_id, "countdown", msg_cb) do
    {:ok, now} = DateTime.now("America/Denver")
    msg_cb.([
      MessagingService.greeting_based_on_time(user_id, now),
      MessagingService.time_left(now),
      DateTime.to_unix(now),
      MessagingService.generate_random_color
    ])
  end

  defp custom_messages(query, "pokedex", msg_cb) do
    case PokemonService.call(query) do
      %{error: true} -> nil
      data -> PokemonService.format_response(data) |> msg_cb.()
    end
  end
end
