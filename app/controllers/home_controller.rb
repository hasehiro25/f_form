# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    @forms = current_user.forms
  end
end
