class Artist < ApplicationRecord
  has_many :entry_artists, dependent: :destroy
  has_many :exhibitions, through: :entry_artists

  has_many_attached :artist_images

  validates :name, presence: true, uniqueness: true, length: { maximum: 255 }
  validates :introduction, presence: true, length: { maximum: 255 }
  validates :is_active, inclusion: { in: [true, false] }

  def get_artist_images(width, height)
    first_image = artist_images.first
    first_image.variant(resize: "#{width}x#{height}^", gravity: 'center', extent: "#{width}x#{height}").processed
  end
end