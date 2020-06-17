# frozen_string_literal: true

require "rails_helper"

RSpec.describe UrlHelper do
  describe "#endpoint_url" do
    let(:user) { create(:activated_user) }
    let(:form) { create(:form, user: user) }
    it "should create url with endpoint" do
      p root_url
      expect(endpoint_url(form.endpoint_id)).to eq "#{root_url}api/v1/forms/#{form.endpoint_id}"
    end
  end

  describe "#fform_core_js_url" do
    it "should create url for fform_core.js" do
      expect(fform_core_js_url).to eq "#{root_url}fform_core.js"
    end
  end
end
