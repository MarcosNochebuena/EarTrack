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
end
