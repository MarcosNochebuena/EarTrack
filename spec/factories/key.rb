# frozen_string_literal: true

FactoryBot.define do
  factory :key do
    num_key { rand(1000..9999) }
    upp { rand(100..999) }
    association :producer
  end
end
