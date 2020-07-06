# frozen_string_literal: true

require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
  describe "activation_needed_email" do
    let(:user) { create(:user) }
    let(:mail) { UserMailer.activation_needed_email(user) }

    it "renders the headers" do
      expect(mail.subject).to eq("F-FORMへのご登録ありがとうございます")
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq(["noreply@fform-demo.herokuapp.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("アカウント登録ありがとうございます。")
    end
  end

  describe "activation_success_email" do
    let(:user) { create(:user) }
    let(:mail) { UserMailer.activation_success_email(user) }

    it "renders the headers" do
      expect(mail.subject).to eq("メールアドレスの認証に成功しました")
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq(["noreply@fform-demo.herokuapp.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("メールアドレスの認証に成功いたしました。")
    end
  end
end
