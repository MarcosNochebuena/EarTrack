class Key < ApplicationRecord
    has_many :earrings
    validates :num_key, :upp, presence: :true
end
