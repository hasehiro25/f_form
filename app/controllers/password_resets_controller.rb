# frozen_string_literal: true

class PasswordResetsController < ApplicationController
  skip_before_action :require_login

  def index
  end

  def create
    @user = User.find_by_email(params[:email])
    @user.deliver_reset_password_instructions! if @user
    redirect_to login_path, notice: "パスワードリセットのメールを送信しました"
  end

  def edit
    @token = params[:id]
    @user = User.load_from_reset_password_token(params[:id])

    if @user.blank?
      redirect_to login_path
      nil
    end
  end

  def update
    @token = params[:id]
    @user = User.load_from_reset_password_token(params[:id])
    if @user.blank?
      not_authenticated
      return
    end
    @user.password_confirmation = params[:user][:password_confirmation]
    if @user.change_password(params[:user][:password])
      redirect_to(login_path, notice: "パスワードを変更しました")
    else
      render action: "edit"
    end
  end
end
