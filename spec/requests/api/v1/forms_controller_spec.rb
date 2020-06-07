# frozen_string_literal: true

require "rails_helper"

describe Api::V1::FormsController, type: :request do
  describe "POST #create" do
    let!(:user) { create(:activated_user) }
    let(:form) { create(:form, user: user) }
    context "with proper domain" do
      subject { post api_v1_form_url(form.endpoint_id), params: { "お名前": "太郎", "内容": "こんにちは" }, headers: { "Origin" => "http://example.com" } }
      it "should redirect to redirect_url" do
        subject
        expect(response).to redirect_to(form.redirect_url)
      end

      it "should send email to user" do
        ActionMailer::Base.deliveries = []
        expect { subject }.to change { ActionMailer::Base.deliveries.count }.by(1)
        expect(ActionMailer::Base.deliveries.last.subject).to eq "お問い合わせがありました"
        expect(ActionMailer::Base.deliveries.last.to).to eq [user.email]
      end

      context "with redirect_url" do
        it "should redirect to the url" do
          subject
          expect(response).to redirect_to(form.redirect_url)
        end
      end

      context "with no redirect_url" do
        let(:form) { create(:form_without_redirect, user: user) }
        subject { post api_v1_form_url(form.endpoint_id), params: { "お名前": "太郎", "内容": "こんにちは" }, headers: { "Origin" => "http://example.com" } }
        it "should redirect to thank you page" do
          subject
          expect(response).to redirect_to(thankyou_path)
        end
      end
    end

    context "with unproper domain" do
      subject { post api_v1_form_url(form.endpoint_id), params: { "お名前": "太郎", "内容": "こんにちは" }, headers: { "Origin" => "http://wrong.domain" } }
      it "should raise error when domain doesn't match" do
        expect { subject }.to raise_error(RuntimeError, "unauthorized domain")
      end
    end
  end
end
