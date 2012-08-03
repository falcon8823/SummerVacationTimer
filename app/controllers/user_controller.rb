# coding: utf-8
class UserController < ApplicationController
  before_filter :auth

  def edit
    if @user
      render :edit
    else
      redirect_to :root, notice: 'Twitterで認証していません' unless @user
    end
  end

  def update
    if @user
      if @user.update_attributes params[:user]
        redirect_to :root, notice: '変更を保存しました'
      end
    else
      redirect_to :root, notice: 'Twitterで認証していません' unless @user
    end
    rescue
      redirect_to :root, notice: 'エラーです。正常に処理を完了できませんでした。'
  end

  def destroy
    if @user
      session[:user_id] = nil
      @user.destroy
      redirect_to :root, notice: '登録を解除しました'
    else
      redirect_to :root, notice: 'Twitterで認証していません' unless @user
    end
    rescue
      redirect_to :root, notice: 'エラーです。正常に処理を完了できませんでした。'
  end

  private

  def auth
    @user = current_user
  end
end
