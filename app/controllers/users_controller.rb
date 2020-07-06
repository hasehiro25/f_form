# frozen_string_literal: true

class UsersController < ApplicationController
  skip_before_action :require_login, only: [:new, :create, :activate]

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to login_path, notice: "認証メールを送信しました"
    else
      render "signup/new"
    end
  end

  def activate
    if @user = User.load_from_activation_token(params[:id])
      @user.activate!
      redirect_to login_path, notice: "アカウントを作成しました"
    else
      not_authenticated
    end
  end

  private
    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation)
    end
end
