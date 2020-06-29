# frozen_string_literal: true

WebMock.disable_net_connect!(
  allow_localhost: true,
  allow: "chromedriver.storage.googleapis.com"
)

require "rails_helper"

RSpec.describe "Change Email" do
  let!(:user) { create :activated_user }
  before do
    login_user(user.email, "hogehoge")
  end
  describe "when email is edited" do
    it "should send email and able to confirm" do
      visit root_path
      click_on "アカウント設定"
      click_on "アドレスを変更"

      fill_in "user_email", with: "newaddress@sample.com"
      expect { click_on "更新する" }.to change { ActionMailer::Base.deliveries.count }.by (1)

      email = ActionMailer::Base.deliveries.last
      body = email.body.raw_source
      raw_token = body.match(/unconfirmed_email\/(.{20})/)[1] # メールにしかraw_tokenがのってないのでregexで取得

      visit confirm_unconfirmed_email_path(raw_token)
      expect(page.body).to match "メールアドレスを更新しました"
      expect(user.reload.email).to eq "newaddress@sample.com"
    end
  end
end
