# frozen_string_literal: true

require "rails_helper"

RSpec.describe "login", type: :system do
  let(:user) { create :activated_user }
  describe "login" do
    it "should login" do
      visit login_path
      fill_in "user_email", with: user.email
      fill_in "user_password", with: "hogehoge"
      find("input[type=submit]").click
      expect(page.body).to match "ログインしました"
    end
  end
end
