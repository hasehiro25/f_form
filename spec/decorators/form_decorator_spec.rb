# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Form Decorator" do
  let(:user) { create :activated_user }
  describe "#redirect_url" do
    context "with url" do
      let(:form) { create :form, user: user, redirect_url: "https://example.com" }
      it "should return url" do
        expect(form.decorate.redirect_url).to eq form.redirect_url
      end
    end
    context "without url" do
      let(:form) { create :form, user: user, redirect_url: "" }
      it "should return 'なし'" do
        expect(form.decorate.redirect_url).to eq "なし"
      end
    end
  end
  describe "#recaptcha_status" do
    context "with recaptcha true" do
      let(:form) { create :form, user: user, recaptcha_status: true }
      it "should return 'あり'" do
        expect(form.decorate.recaptcha_status).to eq "あり"
      end
    end
    context "with recaptcha true" do
      let(:form) { create :form, user: user, recaptcha_status: false }
      it "should return 'なし'" do
        expect(form.decorate.recaptcha_status).to eq "なし"
      end
    end
  end
end
