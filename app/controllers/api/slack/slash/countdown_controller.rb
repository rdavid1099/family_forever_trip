class Api::Slack::Slash::CountdownController < Api::ApiController
  include DateHelper

  def create
    time_left = DateHelper.time_until_vacation

    SlackMsgr.chat(:post_message, {
      channel: params[:channel_id],
      text: "#{Mildred.intro("<@#{params[:user_id]}>")} Let's see how much time is left until our big trip!",
      attachments: [
        Mildred.msg_attachment(
          title: "It's The Final Countdown!",
          text: "There #{time_left[:complete]} left.\nThat's #{time_left[:days]}... or #{time_left[:minutes]}!\n",
          random_giphy: ['excite', 'fun', 'san diego', 'road trip'][rand(4)],
          ts: Time.now.to_i
        )
      ]
    })

    head 200, content_type: "text/html"
  end
end
