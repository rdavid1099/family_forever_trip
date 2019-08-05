defmodule FamilyForeverPhoenixWeb.Services.MessagingService do
  def greeting_based_on_time(user_id, now) do
    greeting = case now.hour do
      n when n >= 4 and n < 11 -> "morning"
      n when n >= 11 and n < 17 -> "afternoon"
      n when n >= 17 and n < 4 -> "evening"
    end
    "Well, good #{greeting}, #{if user_id == "Deary", do: user_id, else: "<@#{user_id}>" }!"
  end

  def time_left(now) do
    days = Calendar.Date.diff({2019, 10, 5}, {now.year, now.month, now.day})
    minutes = (days * 24 * 60) + ((24 - now.hour) * 60) + now.minute
    seconds = (minutes * 60) + now.second
    "There are just #{days} days left!\nThat's #{minutes} minutes... or #{seconds} seconds!"
  end

  def generate_random_color(result \\ "#") do
    case String.length(result) do
      length when length < 7 -> generate_random_color(result <> Integer.to_string(Enum.random(0..16), 16))
      _ -> result
    end
  end
end
