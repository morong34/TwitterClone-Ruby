# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    sequence(:email) { |_n| 'test@test.com' }
    password { 'password' }
    username { Faker::Internet.username }
  end
end
