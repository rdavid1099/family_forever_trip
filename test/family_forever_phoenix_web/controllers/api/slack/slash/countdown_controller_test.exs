defmodule FamilyForeverPhoenixWeb.Api.Slack.Slash.CountdownControllerTest do
  use FamilyForeverPhoenixWeb.ConnCase

  test "POST /", %{conn: conn} do
    System.put_env("SLACK_APP_TOKEN", "12345")
    params = %{
      "channel_name" => "announcements",
      "token" => "12345",
      "user_id" => "tester"
    }
    conn = post(conn, Routes.countdown_path(conn, :create, params))

    assert json_response(conn, 200) == %{
      "channel" => params["channel"],
      "response_type" => "in_channel",
      "text" => "Well, good morning, <@tester>! Let's see how much time is left until our big trip!",
      "attachments" => [%{
        "title" => "It's The Final Countdown!",
        "text" => "There are 2 weeks left.\nThat's 14 days... or 12345 minutes!\n",
        "image_url" => "super_fun_giphy",
        "ts" => "123456789",
        "color" => "#ffffff"
      }]
    }
  end
end
