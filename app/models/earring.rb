class Earring < ApplicationRecord
  belongs_to :key
  has_one_attached :photo 

  enum status: { live: "vivo", dead: "muerto", saled: "vendido" }

  validates :earring, :status, :age, :gender,  presence: true

  validates :earring, format: { with: /\A\d{4}\z/ }, numericality: { greater_than_or_equal_to: 0, only_integer: true }

  validates :age, numericality: { greater_than: 0, only_integer: true }

end
