# frozen_string_literal: true
# == Schema Information
#
# Table name: producers
#
#  id                 :integer          not null, primary key
#  upp_key            :string
#  producer_full_name :string
#  produced_address   :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class Producer < ApplicationRecord
  has_many :users
  has_many :keys
  has_many :earrings, through: :keys
  validates :upp_key, presence: true, uniqueness: true
  validates :producer_full_name, presence: true, uniqueness: true
end
