# coding: utf-8
require 'twitter'

class User < ActiveRecord::Base
  scope :active, lambda { where('end_date >= ?', Date.today) }

  validates :uid, uniqueness: true
  validates :end_date, presence: true

  attr_accessible :end_date
  
  def lastdays
    (self.end_date - Date.today).to_i + 1
  end

  def self.create_with_omniauth(auth)
    user = User.new
    user.provider = auth['provider']
    user.uid = auth['uid']
    user.end_date = Date.today
    
    user.oauth_token = auth['credentials']['token']
    user.oauth_token_secret = auth['credentials']['secret']

    unless auth['info'].blank?
      user.name = auth['info']['name']
      user.screen_name = auth['info']['nickname']
      user.image = auth['info']['image']
    end
  
    user.save

    return user
  end

  def self.all_tweet
    Twitter.configure do |config|
      config.consumer_key = SummerVacationTimer::Application.config.consumer_key
      config.consumer_secret = SummerVacationTimer::Application.config.consumer_secret
    end
    
    users = User.active

    users.each do |u|
      Twitter.configure do |config|
        config.oauth_token = u.oauth_token
        config.oauth_token_secret = u.oauth_token_secret
      end
      
      begin
        Twitter.update ".@#{u.screen_name} お前の夏休みはあと#{u.lastdays}日しかないぞ！ http://ndays.falconsrv.net #夏休みはあとn日しかない"
      rescue
      end
      sleep 0.1
    end
  end

end
