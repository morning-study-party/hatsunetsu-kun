class LineBotController < ApplicationController
  protect_from_forgery except: [:callback]
  def callback
  end

  private
 
  def client
    @client ||= Line::Bot::Client.new { |config|
      config.channel_secret = Rails.application.credentials.dig(:line, :channel_secret)
      config.channel_token = Rails.application.credentials.dig(:line, :channel_token)
    }
  end
end
