# frozen_string_literal: true

require "rails_helper"

RSpec.describe RecaptchaChecker do
  describe "#valid_token" do
    let(:recaptcha_checker) { RecaptchaChecker.new(token: "valid_token", registered_domain: "example.com") }
    context "with valid token" do
      before do
        stub_request(:post, "https://www.google.com/recaptcha/api/siteverify").
          to_return(
            body: { "success": true, "hostname": "example.com" }.to_json,
            status: 200,
            headers: { "Content-Type"=> "application/json" }
          )
      end
      it "should return true" do
        expect(recaptcha_checker.valid_token?).to eq true
      end

      context "with invalid hostname" do
        before do
          stub_request(:post, "https://www.google.com/recaptcha/api/siteverify").
            to_return(
              body: { "success": true, "hostname": "wronghost.com" }.to_json,
              status: 200,
              headers: { "Content-Type"=> "application/json" }
            )
        end
        it "should return false" do
          expect(recaptcha_checker.valid_token?).to eq false
        end
      end
    end

    context "with invalid token" do
      let(:recaptcha_checker) { RecaptchaChecker.new(token: "invalid_token", registered_domain: "example.com") }
      before do
        stub_request(:post, "https://www.google.com/recaptcha/api/siteverify").
        to_return(
          body: { "success": false, "hostname": "example.com" }.to_json,
          status: 200,
          headers: { "Content-Type"=> "application/json" }
        )
      end
      it "should return false" do
        expect(recaptcha_checker.valid_token?).to eq false
      end
    end
  end
end
