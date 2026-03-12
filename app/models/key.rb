# frozen_string_literal: true
# == Schema Information
#
# Table name: keys
#
#  id          :integer          not null, primary key
#  num_key     :string
#  upp         :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  producer_id :integer
#
# Indexes
#
#  index_keys_on_producer_id  (producer_id)
#

class Key < ApplicationRecord
  belongs_to :producer
  has_many :earrings, dependent: :destroy
  validates :num_key, :upp, presence: true
  validates :num_key, uniqueness: { scope: :producer_id }

  def self.ransackable_attributes(_auth_object = nil)
    %w[created_at id num_key updated_at upp]
  end
end
