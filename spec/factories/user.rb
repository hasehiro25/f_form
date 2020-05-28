# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { "sample@example.comm" }
    password { "hogehoge" }
    password_confirmation { "hogehoge" }
    factory :activated_user do
      after(:create) do |user|
        user.activate!
      end
    end
  end
end
