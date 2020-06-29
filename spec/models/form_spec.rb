# frozen_string_literal: true

require "rails_helper"

RSpec.describe Form, type: :model do
  describe "when form is created" do
    let(:user) { create(:activated_user) }
    let(:form) { build(:form, user: user) }
    it "should save form" do
      expect(form.save).to eq false
    end
    it "should have uuid in endpoint_id" do
      form.save
      expect(form.endpoint_id).to match(/\w{8}-\w{4}-\w{4}-\w{4}-\w{12}/)
    end
  end
end
