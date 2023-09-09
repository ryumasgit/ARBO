class EntryArtist < ApplicationRecord
  belongs_to :exhibition
  belongs_to :artist

  has_many_attached :artist_images, default_url: Rails.root.join("app/assets/images/default_artist_image.jpeg")

  validates :name, presence: true, uniqueness: true
  validates :introduction, presence: true, length: { maximum: 255 }
  validates :is_active, presence: true, inclusion: { in: [true, false] }
  validate :validate_artist_images_count

  def get_artist_images(width, height)
    if artist_images.attached?
      artist_images.variant(resize_to_limit: [width, height]).processed
    else
      ActionController::Base.helpers.asset_path("default_artist_image.jpeg")
    end
  end

  private

  def validate_artist_images_count
    if artist_images.attached? && artist_images.length > 4
      errors.add(:artist_images, "は最大4つまでです")
    end
  end
end