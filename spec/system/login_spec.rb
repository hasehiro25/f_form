# frozen_string_literal: true

WebMock.disable_net_connect!(
  allow_localhost: true,
  allow: "chromedriver.storage.googleapis.com"
)

require "rails_helper"

RSpec.describe "login", type: :system do
  let(:user) { create :activated_user }
  describe "login" do
    it "should login" do
      visit login_path
      fill_in "user_email", with: user.email
      fill_in "user_password", with: "hogehoge"
      click_on "ログイン"
      expect(page.body).to match "ログインしました"
    end
  end
end
