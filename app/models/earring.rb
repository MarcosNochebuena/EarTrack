# == Schema Information
#
# Table name: earrings
#
#  id         :bigint           not null, primary key
#  age        :integer
#  earring    :integer
#  gender     :string
#  status     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  key_id     :bigint           not null
#
# Indexes
#
#  index_earrings_on_key_id  (key_id)
#
# Foreign Keys
#
#  fk_rails_...  (key_id => keys.id)
#
class Earring < ApplicationRecord
  belongs_to :key
  has_one_attached :photo 

  enum status: { live: "vivo", dead: "muerto", saled: "vendido" }
  enum gender: { female: "Hembra", male: "Macho" }

  validates :earring, :status, :age, :gender,  presence: true

  validates :earring, format: { with: /\A\d{4}\z/ }, numericality: { greater_than_or_equal_to: 0, only_integer: true }

  validates :age, numericality: { greater_than: 0, only_integer: true }

  def self.ransackable_attributes(auth_object = nil)
    ["age", "created_at", "earring", "gender", "id", "key_id", "status", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["key"]
  end

  ransacker :earring do
    Arel.sql("to_char(earring, '9999999')")
  end
end
