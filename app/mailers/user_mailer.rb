# frozen_string_literal: true

class UserMailer < ApplicationMailer
  def activation_needed_email(user)
    @user = user
    @url  = activate_user_url(@user.activation_token)
    mail(to: user.email, subject: "F-Formへのご登録ありがとうございます")
  end

  def activation_success_email(user)
    @user = user
    @url  = login_url
    mail(to: user.email, subject: "メールアドレスの認証に成功しました")
  end

  def reset_password_email(user)
    @user = User.find user.id
    @url  = edit_password_reset_url(@user.reset_password_token)
    mail(to: user.email,
         subject: "パスワードリセットを受け付けました")
  end

  def confirm_new_address_email(unconfirmed_email)
    @url = confirm_unconfirmed_email_url(id: unconfirmed_email.raw_token)
    @email = unconfirmed_email.email
    mail(to: unconfirmed_email.email,
      subject: "メールアドレス変更のリクエストを受け付けました")
  end
end
