# frozen_string_literal: true

class AccountsController < ApplicationController
  def show
  end

  def destroy
    current_user.destroy
    redirect_to login_path, notice: "アカウントを削除しました"
  end
end
