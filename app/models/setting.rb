class Setting < ApplicationRecord
  validates :upp_key, presence: true
  validates :producer_full_name, presence: true
end
