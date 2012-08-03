# coding: utf-8

class SessionsController < ApplicationController

  def callback
    auth = request.env['omniauth.auth']

    session[:user_id] = nil
    if user = User.find_by_provider_and_uid(auth['provider'], auth['uid'])
      session[:user_id] = user.id
      redirect_to :root, notice: 'Twitterで認証されました！'
    else
      user = User.create_with_omniauth(auth)
      session[:user_id] = user.id
      redirect_to :user_edit, notice: '夏休みの最終日を設定してください'
    end

  end

  def destroy
    session[:user_id] = nil
    redirect_to :root, notice: 'サインアウトしました'
  end

  def failure
    render text: '<span style="color: red">Twitterでの認証に失敗しました</span>'
  end
end
