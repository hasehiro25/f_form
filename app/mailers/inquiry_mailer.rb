# frozen_string_literal: true

class InquiryMailer < ApplicationMailer
  helper ApplicationHelper
  def inquiry_info
    @user = params[:user]
    @data = params[:data]
    @form = params[:form]
    mail(to: @user.email, subject: "お問い合わせがありました")
  end
end
