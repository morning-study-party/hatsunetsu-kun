class LineBotController < ApplicationController
  protect_from_forgery except: [:callback]
  def callback
  end
end
