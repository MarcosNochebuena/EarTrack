# == Schema Information
#
# Table name: keys
#
#  id         :bigint           not null, primary key
#  num_key    :string
#  upp        :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Key < ApplicationRecord
    has_many :earrings
    validates :num_key, :upp, presence: :true

    def self.ransackable_attributes(auth_object = nil)
        ["created_at", "id", "num_key", "updated_at", "upp"]
    end
end
