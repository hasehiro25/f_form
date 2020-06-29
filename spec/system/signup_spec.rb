# frozen_string_literal: true

WebMock.disable_net_connect!(
  allow_localhost: true,
  allow: "chromedriver.storage.googleapis.com"
)

require "rails_helper"

RSpec.describe "signup", type: :system do
  it "should make account and able to login" do
    visit login_path
    click_on "アカウントを作成"
    fill_in "user_email", with: "sample123@sample.com"
    fill_in "user_password", with: "password"
    fill_in "user_password_confirmation", with: "password"

    expect { click_on "登録する" }.to change { ActionMailer::Base.deliveries.count }.by 1
    expect(ActionMailer::Base.deliveries.last.subject).to match "Formへのご登録ありがとうございます"

    visit activate_user_path(User.last.reload.activation_token)
    expect(page.body).to match "アカウントを作成しました"

    fill_in "user_email", with: "sample123@sample.com"
    fill_in "user_password", with: "password"
    click_on "ログイン"
    expect(page.body).to match "ログインしました"
  end
end
