# frozen_string_literal: true

require "rails_helper"

RSpec.describe InquiryMailer, type: :mailer do
  describe "inquery_info" do
    data = {
      "名前": "太郎",
      "内容": "こんにちは"
    }

    let(:user) { create(:activated_user) }
    let(:form) { create(:form, user: user) }
    let(:mail) { InquiryMailer.with(user: user, data: data, form: form).inquiry_info }

    it "renders the header" do
      expect(mail.subject).to eq("お問い合わせがありました")
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq(["noreply@fform-demo.herokuapp.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("#{form.name}にお問い合わせがありました")
      expect(mail.body.encoded).to match("<dd><p>太郎</p></dd>")
    end
  end
end
