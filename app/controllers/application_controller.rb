class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception

  before_filter :initialize_twitter_client

  private
  def initialize_twitter_client
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key    = Rails.application.secrets.twitter['consumer_key']
      config.consumer_secret = Rails.application.secrets.twitter['consumer_secret']
    end
  end
end
