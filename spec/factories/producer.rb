# frozen_string_literal: true

FactoryBot.define do
  factory :producer do
    producer_full_name { "Producer #{rand(1000..9999)}" }
    produced_adress { '123 Main St, City, Country' }
    upp_key { rand(1_000_000_000..9_999_999_999) }

    # You can add more attributes as needed
  end
end
