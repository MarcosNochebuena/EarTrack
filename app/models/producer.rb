# == Schema Information
#
# Table name: producers
#
#  id                 :bigint           not null, primary key
#  produced_adress    :string
#  producer_full_name :string
#  upp_key            :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
class Producer < ApplicationRecord
  has_many :users
  has_many :keys
  has_many :earrings, through: :keys
  validates :upp_key, presence: true
  validates :producer_full_name, presence: true
end
