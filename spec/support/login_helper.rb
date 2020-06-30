# frozen_string_literal: true

module LoginHelper
  def login_user(email, password)
    visit login_path
    fill_in "user_email", with: email
    fill_in "user_password", with: password
    find("input[type=submit]").click
  end
end
