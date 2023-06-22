class Earring < ApplicationRecord
  belongs_to :key
  has_one_attached :photo 
end
