class Api::Slack::Slash::PokedexController < Api::ApiController
  def create

    head 200, content_type: "text/html"
  end
end
