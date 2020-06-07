# frozen_string_literal: true

FactoryBot.define do
  factory :form do
    name { "sampleform" }
    domain { "example.com" }
    redirect_url { "https://exampl.com/thankyou" }
  end

  factory :form_without_redirect, class: Form do
    name { "sampleform2" }
    domain { "example.com" }
  end
end
