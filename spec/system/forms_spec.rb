# frozen_string_literal: true

WebMock.disable_net_connect!(
  allow_localhost: true,
  allow: "chromedriver.storage.googleapis.com"
)

require "rails_helper"

RSpec.describe "forms", type: :system do
  let!(:user) { create :activated_user }
  before do
    login_user(user.email, "hogehoge")
  end

  describe "show form" do
    let!(:form) { create :form, user: user }
    it "should show form" do
      visit root_path
      expect(page.body).to match "sampleform"
    end
  end

  describe "create form" do
    context "without recaptcha" do
      it "should create form" do
        visit root_path
        click_on "新しいフォームを作る"

        fill_in "form_name", with: "テストフォーム"
        fill_in "form_domain", with: "sample.com"
        fill_in "form_redirect_url", with: "sample.com/thankyou"

        expect { click_on "フォーム作成" }.to change { Form.count }.by 1
        expect(page.body).to match "新しいフォームを作成しました"
        expect(page.body).not_to match 'class="g-recaptcha"'
      end
    end

    context "with recaptcha" do
      it "should create form with recaptcha sample html" do
        # login_user(user.email, "hogehoge")
        visit root_path
        click_on "新しいフォームを作る"

        fill_in "form_name", with: "テストフォーム"
        fill_in "form_domain", with: "sample.com"
        fill_in "form_redirect_url", with: "sample.com/thankyou"
        check "form_recaptcha_status"

        expect { click_on "フォーム作成" }.to change { Form.count }.by 1
        expect(page.body).to match "新しいフォームを作成しました"
        expect(page.body).to match 'class="g-recaptcha"'
      end
    end
  end

  describe "edit form" do
    let!(:form) { create :form, user: user }
    it "should update form" do
      visit root_path
      click_on form.name
      click_on "フォームを編集する"

      fill_in "form_name", with: "sampleform updated"
      click_on "フォーム作成"
      expect(page.body).to match "フォーム内容を更新しました"
      expect(form.reload.name).to eq "sampleform updated"
    end
  end

  describe "delete form" do
    let!(:form) { create :form, user: user }
    it "should delete form" do
      visit root_path
      click_on form.name
      expect {
        page.accept_confirm { click_on "フォームを削除する" }
        expect(page.body).to match "フォームを削除しました"
      }
      .to change { Form.count }.by(-1)
    end
  end
end
