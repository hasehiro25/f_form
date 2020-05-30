# frozen_string_literal: true

class Api::V1::FormsController < ApplicationController
  skip_before_action :require_login
  protect_from_forgery

  def show
  end

  def create
    p "success to do"
    @form = Form.find_by!(endpoint_id: params[:id])
    raise "unauthorized domain" if unauthorized_domain?

    # convert to hash

    # check for xss
    # save to db
    # send email

    p request.headers[:HTTP_ORIGIN] # domainチェックに使用
    p request.request_parameters.to_h

    redirect_to @form.redirect_url
  end

  private
    def unauthorized_domain?
      !authorized_domain?
    end

    def authorized_domain?
      domain = request.headers[:HTTP_ORIGIN].gsub(/(http|https):\/\//, "")
      domain == @form.domain
    end
end
