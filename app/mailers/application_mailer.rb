# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: "F-FORM <noreply@fform-demo.herokuapp.com>"
  layout "mailer"
end
