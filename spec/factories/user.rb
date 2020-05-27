# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { "sample@example.comm" }
    password { "hogehoge" }
    password_confirmation { "hogehoge" }
  end
end
