# frozen_string_literal: true

class ThankyouController < ApplicationController
  skip_before_action :require_login, only: [:index]

  def index
  end
end
