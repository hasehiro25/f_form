# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: "F-Form <noreply@stage-form-maker.herokuapp.com>"
  layout "mailer"
end
