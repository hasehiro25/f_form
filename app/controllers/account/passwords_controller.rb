# frozen_string_literal: true

class Account::PasswordsController < ApplicationController
  def edit
  end

  def update
    if current_user.update(password_params)
      redirect_to root_path, notice: "パスワードを更新しました"
    else
      render "edit"
    end
  end

  private
    def password_params
      params.require(:user).permit(:password, :password_confirmation)
    end
end
