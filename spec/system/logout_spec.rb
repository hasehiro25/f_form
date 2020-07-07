# frozen_string_literal: true

require "rails_helper"

RSpec.describe "logout", type: :system do
  let!(:user) { create :activated_user }
  describe "logout" do
    it "should logout" do
      login_user(user.email, "hogehoge")
      visit root_path
      click_on "ログアウト"
      expect(page.body).to match "ログアウトしました"
    end
  end
end
