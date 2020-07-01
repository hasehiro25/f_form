# frozen_string_literal: true

class HomeController < ApplicationController
  skip_before_action :require_login
  def index
    if logged_in?
      @forms = current_user.forms
    else
      render template: "welcome/index"
    end
  end
end
