# frozen_string_literal: true

class AddRecaptchaStatusToForms < ActiveRecord::Migration[6.0]
  def change
    add_column :forms, :recaptcha_status, :boolean, null: false, default: false
  end
end
