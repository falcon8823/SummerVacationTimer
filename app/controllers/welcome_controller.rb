class WelcomeController < ApplicationController
  def top
    @users = User.all
  end
end
