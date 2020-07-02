# frozen_string_literal: true

class SignupController < ApplicationController
  skip_before_action :require_login
  def new
    redirect_to root_path if logged_in?
    @user = User.new
  end
end
