# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: "F-FORM <noreply@stage-form-maker.herokuapp.com>"
  layout "mailer"
end
