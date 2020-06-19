# frozen_string_literal: true

class AccountsController < ApplicationController
  def edit
  end

  def update
    if current_user.update(user_params)
      redirect_to root_path, notice: "アカウントを更新しました"
    else
      render "edit"
    end
  end

  private
    def user_params
      params.require(:user).permit(:email)
    end
end
