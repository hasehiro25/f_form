# frozen_string_literal: true

require "rails_helper"

RSpec.describe "delete account", type: :system do
  let!(:user) { create :activated_user }
  before do
    login_user(user.email, "hogehoge")
  end
  it "should delete account" do
    visit root_path
    click_on "アカウント設定"
    expect {
      page.accept_confirm  { click_on "アカウントの削除" }
      expect(page.body).to match "アカウントを削除しました"
    }
    .to change { User.count }.by(-1)
  end
end
