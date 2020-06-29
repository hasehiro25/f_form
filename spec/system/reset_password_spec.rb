# frozen_string_literal: true


WebMock.disable_net_connect!(
  allow_localhost: true,
  allow: "chromedriver.storage.googleapis.com"
)
require "rails_helper"

RSpec.describe "reset password", type: :system do
  let!(:user) { create :activated_user }
  it "should reset password" do
    visit login_path
    click_on "パスワードを忘れた場合"

    fill_in "email", with: user.email
    expect { click_on "送信" }.to change { ActionMailer::Base.deliveries.count }.by 1

    visit edit_password_reset_path(user.reload.reset_password_token)
    fill_in "user_password", with: "newpassword"
    fill_in "user_password_confirmation", with: "newpassword"
    click_on "更新する"
    expect(page.body).to match "パスワードを変更しました"

    fill_in "user_email", with: user.email
    fill_in "user_password", with: "newpassword"
    click_on "ログイン"
    expect(page.body).to match "ログインしました"
  end
end
