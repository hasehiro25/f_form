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

    context "with recaptcha" do
      let(:form) { create(:form, user: user, recaptcha_status: true) }
      context "with valid recaptcha response" do
        before do
          recaptcha_checker_mock = double("Recaptcha Checker")
          allow(recaptcha_checker_mock).to receive(:valid_token?).and_return (true)
          allow_any_instance_of(Api::V1::FormsController).to receive(:recaptcha_checker).and_return(recaptcha_checker_mock)
        end
        subject { post api_v1_form_url(form.endpoint_id), params: { "お名前": "太郎", "内容": "こんにちは", "g-recaptcha-response": "some-token" }, headers: { "Origin" => "http://example.com" } }
        it "should send email" do
          subject
          expect(response).to redirect_to(form.redirect_url)
        end

        it "should save to database" do
          expect { subject }.to change { Inquiry.count }.by 1
        end

        it "shouldn't have g-recaptcha-response" do
          subject
          expect(Inquiry.last).not_to match " g-recaptcha-response"
        end
      end
    end
  end
end
