class User < ActiveRecord::Base

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

    unless auth['info'].blank?
      user.name = auth['info']['name']
      user.screen_name = auth['info']['nickname']
      user.image = auth['info']['image']
    end
  
    user.save

    return user
  end
end
