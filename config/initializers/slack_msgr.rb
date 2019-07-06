SlackMsgr.configure do |config|
  config.verification_token = ENV['SALCK_APP_TOKEN']
  config.client_secret      = ENV['SLACK_CLIENT_SECRET']
  config.signing_secret     = ENV['SLACK_SIGNING_SECRET']
  config.access_tokens      = {
    bot: ENV['SLACK_BOT_AUTH_TOKEN'],
    me: ENV['SLACK_AUTH_TOKEN']
  }
end
