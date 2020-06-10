# frozen_string_literal: true

class Api::V1::FormsController < ApplicationController
  skip_before_action :require_login
  protect_from_forgery

  def show
  end

  def create
    @form = Form.find_by!(endpoint_id: params[:id])
    raise "unauthorized domain" if unauthorized_domain?
    data = request.request_parameters.to_h
    if data.has_key?("g-recaptcha-response")
      check_recaptcha(data["g-recaptcha-response"], @domain)
      data.delete("g-recaptcha-response")
    end
    @form.inquiries.create!(content: data.to_json)
    InquiryMailer.with(form: @form, user: @form.user, data: data).inquiry_info.deliver_now
    @form.redirect_url? ? redirect_to(@form.redirect_url) : redirect_to(thankyou_url)
  end

  private
    def unauthorized_domain?
      !authorized_domain?
    end

    def authorized_domain?
      @domain ||= request.headers[:HTTP_ORIGIN].gsub(/(http|https):\/\//, "")
      @domain == @form.domain
    end

    def check_recaptcha(token, registered_domain)
      recaptcha_checker =  RecaptchaChecker.new({ token: token, registered_domain: registered_domain })
      raise "unauthorized" unless recaptcha_checker.valid_token?
    end
end
