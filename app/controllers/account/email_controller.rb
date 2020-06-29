# frozen_string_literal: true

class Account::EmailController < ApplicationController
  def edit
  end

  def update
    current_user.unconfirmed_email&.destroy
    email = current_user.build_unconfirmed_email(email: params[:user][:email])
    if email.save
      UserMailer.confirm_new_address_email(email).deliver_now
      redirect_to account_path, notice: "新しいアドレスに認証メールを送信しました"
    else
      render "edit"
    end
  end
end
