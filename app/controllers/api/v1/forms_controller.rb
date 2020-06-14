# frozen_string_literal: true

class Api::V1::FormsController < ApplicationController
  skip_before_action :require_login
  protect_from_forgery

  def show
  end

  def create
    form = Form.find_by!(endpoint_id: params[:id])
    authorize_domain(form.domain)
    data = request.request_parameters.to_h
    process_recaptcha(data, domain,) if data.has_key?("g-recaptcha-response") || form.recaptcha_status?
    form.inquiries.create!(content: data.to_json)
    InquiryMailer.with(form: form, user: form.user, data: data).inquiry_info.deliver_now
    form.redirect_url? ? redirect_to(form.redirect_url) : redirect_to(thankyou_url)
  end

  private
    def authorize_domain(form_domain)
      raise "unauthorized domain" unless domain == form_domain
    end

    def domain
      @domain ||= request.headers[:HTTP_ORIGIN].gsub(/(http|https):\/\//, "")
    end

    def process_recaptcha(data, domain)
      check_recaptcha(data["g-recaptcha-response"], domain)
      data.delete("g-recaptcha-response")
    end

    def check_recaptcha(token, registered_domain)
      raise "unauthorized" unless recaptcha_checker(token, registered_domain).valid_token?
    end

    def recaptcha_checker(token, registered_domain)
      RecaptchaChecker.new({ token: token, registered_domain: registered_domain })
    end
end
