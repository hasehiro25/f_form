# frozen_string_literal: true

FactoryBot.define do
  factory :form do
    name { "sampleform" }
    domain { "example.com" }
    redirect_url { "https://exampl.com/thankyou" }
  end
end
