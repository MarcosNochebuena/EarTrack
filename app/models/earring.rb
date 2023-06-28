class Earring < ApplicationRecord
  belongs_to :key
  has_one_attached :photo 

  enum status: { live: "vivo", dead: "muerto", saled: "vendido" }

end
