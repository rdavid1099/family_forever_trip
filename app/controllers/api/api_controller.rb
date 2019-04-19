class Api::ApiController < ApplicationController
  protect_from_forgery with: :null_session

  before_action :confirm_token

  def confirm_token
    unless ENV["SLACK_APP_TOKEN"] == params[:token]
      raise ActionController::RoutingError.new("Not Found")
    end
  end
end
