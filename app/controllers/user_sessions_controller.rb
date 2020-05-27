# frozen_string_literal: true

class UserSessionsController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]

  def new
    redirect_to root_path if logged_in?
  end

  def create
    @user = login(params[:user][:email], params[:user][:password])
    if @user
      redirect_back_or_to root_path, notice: "ログインしました"
    else
      flash.now[:alert] = "ログインに失敗しました"
      render "new"
    end
  end

  def destroy
    logout
    redirect_to login_path, notice: "ログアウトしました"
  end
end
