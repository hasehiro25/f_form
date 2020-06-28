# frozen_string_literal: true

require "rails_helper"

RSpec.describe TokenGenerator do
  describe "#generate" do
    let(:token_generator) { TokenGenerator.new(UnconfirmedEmail, :email)}
    it "should generate raw and encrypeted token" do
      raw, enc = token_generator.generate
      expect(raw.length).to eq 20 
      expect(enc.length).to eq 64  #SHA256の場合
    end
    it "raw with #digest should match encypeted output" do
      raw, enc = token_generator.generate
      expect(enc).to eq token_generator.digest(raw)
    end   
  end
end
