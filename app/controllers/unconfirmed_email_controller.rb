# frozen_string_literal: true

class UnconfirmedEmailController < ApplicationController
  def confirm
    redirect_to root_path, alert: "メールアドレスの更新に失敗しました" and return unless current_user.unconfirmed_email&.valid_token?(params[:id])

    ApplicationRecord.transaction do
      current_user.update!(email: current_user.unconfirmed_email.email)
      current_user.unconfirmed_email.destroy!
    end
    redirect_to account_path, notice: "メールアドレスを更新しました"
  end
end
