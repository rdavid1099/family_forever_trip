defmodule FamilyForeverPhoenixWeb.Modules.Mildred do
  alias FamilyForeverPhoenixWeb.Services.GiphyService
  alias FamilyForeverPhoenixWeb.Services.MessagingService

  @slash_commands [
    "countdown"
  ]

  @default_params %{
    "user_id" => "Deary"
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

  defp custom_messages(user_id, "countdown", msg_cb) do
    {:ok, now} = DateTime.now("America/Denver")
    msg_cb.([
      MessagingService.greeting_based_on_time(user_id, now),
      MessagingService.time_left(now),
      DateTime.to_unix(now),
      MessagingService.generate_random_color
    ])
  end
end
