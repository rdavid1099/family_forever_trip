defmodule FamilyForeverPhoenixWeb.Modules.Mildred do

  @slash_commands [
    "countdown"
  ]

  @default_params %{
    "user_id" => "Deary"
  }

  def json_slash_response(%{"respond_to" => respond_to, "channel" => channel} = params)
  when respond_to in @slash_commands do
    sanitize_params_with_defaults(params)
      |> response(respond_to)
      |> Map.merge(%{
        channel: channel,
        response_type: params["response_type"],
      })
  end

  defp response(%{"user_id" => _} = params, "countdown") do
    [greeting, time_left, ts] = custom_messages(params, "countdown")
    %{
      text: "#{greeting} Let's see how much time is left until our big trip!",
      attachments: [%{
        title: "It's The Final Countdown!",
        text: time_left,
        image_url: "super_fun_giphy",
        ts: ts,
        color: "#ffffff"
      }]
    }
  end

  defp sanitize_params_with_defaults(params) do
    Map.merge(@default_params, params)
  end

  defp custom_messages(%{"user_id" => user_id}, "countdown") do
    {:ok, now} = DateTime.now("America/Denver")
    [
      greeting_based_on_time(user_id, now),
      time_left(now),
      DateTime.to_unix(now)
    ]
  end

  defp greeting_based_on_time(user_id, now) do
    greeting = case now.hour do
      n when n >= 4 and n < 11 -> "morning"
      n when n >= 11 and n < 17 -> "afternoon"
      n when n >= 17 and n < 4 -> "evening"
    end
    "Well, good #{greeting}, #{if user_id == "Deary", do: user_id, else: "<@#{user_id}>" }!"
  end

  defp time_left(now) do
    days = Calendar.Date.diff({2019, 10, 5}, {now.year, now.month, now.day})
    minutes = (days * 24 * 60) + ((24 - now.hour) * 60) + now.minute
    seconds = (minutes * 60) + now.second
    "There are just #{days} days left!\nThat's #{minutes} minutes... or #{seconds} seconds!"
  end
end
