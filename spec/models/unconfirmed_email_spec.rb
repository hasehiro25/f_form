# frozen_string_literal: true

require "rails_helper"

RSpec.describe UnconfirmedEmail, type: :model do
  let(:user) { create :activated_user }
  let(:unconfirmed_email) { user.build_unconfirmed_email(email: "sample34567@sample.com") }
  describe "create_token when saved" do
    it "should save encoded token" do
      unconfirmed_email.save
      expect(unconfirmed_email.encoded_token).not_to be nil
    end
  end

  describe "#valid_token?" do
    context "with valid token" do
      it "should return true" do
        unconfirmed_email.save
        expect(unconfirmed_email.token_generator.digest(unconfirmed_email.raw_token)).to eq unconfirmed_email.encoded_token
      end
    end
  end

  describe "#uniquness_of_user_email" do
    it "should raise error" do
      unconfirmed_email = user.build_unconfirmed_email(email: user.email)
      unconfirmed_email.save
      expect(unconfirmed_email.errors.full_messages[0]).to eq "Emailはすでに存在します"
    end
  end
end
