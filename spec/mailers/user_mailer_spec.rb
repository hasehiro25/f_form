# frozen_string_literal: true

require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
  describe "activation_needed_email" do
    let(:user) { create(:user) }
    let(:mail) { UserMailer.activation_needed_email(user) }

    it "renders the headers" do
      expect(mail.subject).to eq("Formへのご登録ありがとうございます")
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("アカウント登録ありがとうございます。")
    end
  end

  describe "activation_success_email" do
    let(:user) { create(:user) }
    let(:mail) { UserMailer.activation_success_email(user) }

    it "renders the headers" do
      expect(mail.subject).to eq("Formのアカウントを有効にしました")
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("アカウントを有効にしました。")
    end
  end
end
