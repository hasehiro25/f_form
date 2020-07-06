# frozen_string_literal: true

require "rails_helper"

RSpec.describe User, type: :model do
  describe "email valdiation" do
    let(:user) { build(:user) }
    context "with valid email" do
      it "should create user" do
        expect(user).to be_valid
      end
    end
    context "with non valid email" do
      it "should not be valid" do
        user.email = "nodomain"
        expect(user).not_to be_valid
      end
    end
  end
end
