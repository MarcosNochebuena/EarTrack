# == Schema Information
#
# Table name: earrings
#
#  id         :bigint           not null, primary key
#  age        :integer
#  earring    :integer
#  gender     :integer
#  status     :integer
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

  enum :status, { live: 0, dead: 1, sold: 2 }, default: :live
  enum :gender, { female: 0, male: 1 }

  validates :earring, :status, :gender, presence: true

  validates :earring, format: { with: /\A\d{4}\z/ }, numericality: { greater_than_or_equal_to: 0, only_integer: true },
                      uniqueness: true

  validates :age, numericality: { greater_than: 0, only_integer: true, less_than: 9999 }, if: -> { age.present? }

  validate :acceptable_image

  def self.ransackable_attributes(_auth_object = nil)
    %w[age created_at earring gender id key_id status updated_at]
  end

  def self.ransackable_associations(_auth_object = nil)
    ['key']
  end

  ransacker :earring do
    Arel.sql("to_char(earring, '9999999')")
  end

  def photo_webp
    photo.variant(resize_to_limit: [800, 800], format: :webp,
                  saver: { subsample_mode: 'on', strip: true, interlace: true, lossless: false, quality: 75 }).processed
  end

  private

  def acceptable_image
    return unless photo.attached?

    errors.add(:photo, 'es muy grande') unless photo.byte_size <= 5.megabytes

    acceptable_types = ['image/png', 'image/jpg', 'image/jpeg', 'image/webp']
    return if acceptable_types.include?(photo.content_type)

    errors.add(:photo, 'debe ser un PNG, JPG, JPEG, o WEBP')
  end
end
