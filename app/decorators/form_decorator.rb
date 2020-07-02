# frozen_string_literal: true

class FormDecorator < Draper::Decorator
  delegate_all
  def redirect_url
    object.redirect_url? ? object.redirect_url : "なし"
  end

  def recaptcha_status
    object.recaptcha_status? ? "あり" : "なし"
  end
end
