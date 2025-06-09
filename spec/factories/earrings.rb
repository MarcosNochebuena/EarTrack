# frozen_string_literal: true

FactoryBot.define do
  factory :earring do
    age { rand(1..10) }
    earring { rand(1000..9999) }
    gender { :male }
    status { :live }
    association :key
  end
end
