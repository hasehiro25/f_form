# frozen_string_literal: true

require "rails_helper"

RSpec.describe User, type: :model do
  describe "email valdiation" do
    let(:user) { build(:user) }
    context "with valid email" do
      it "should create user" do
        user.email = "sample@example.com"
        expect(user).to be_valid
      end
    end

    context "with invalide email" do
      context "with no domain" do
        it "should not be valid" do
          user.email = "nodomain"
          expect(user).not_to be_valid
        end
      end

      context "with only doain" do
        it "should not be valid" do
          user.email = "@domain"
          expect(user).not_to be_valid
        end
      end
    end
  end
end
