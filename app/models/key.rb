# == Schema Information
#
# Table name: keys
#
#  id          :bigint           not null, primary key
#  num_key     :string
#  upp         :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  producer_id :bigint
#
# Indexes
#
#  index_keys_on_producer_id  (producer_id)
#
# Foreign Keys
#
#  fk_rails_...  (producer_id => producers.id)
#
class Key < ApplicationRecord
    belongs_to :producer
    has_many :earrings
    validates :num_key, :upp, presence: :true
    validates :num_key, uniqueness: { scope: :producer_id }

    def self.ransackable_attributes(auth_object = nil)
        ["created_at", "id", "num_key", "updated_at", "upp"]
    end
end
