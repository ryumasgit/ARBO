class Museum < ApplicationRecord
  has_many :exhibitions, dependent: :destroy
  has_many :bookmark_museums, dependent: :destroy
  has_many :members, through: :bookmark_museums

  has_many_attached :museum_images

  validates :name, presence: true, uniqueness: true
  validates :introduction, presence: true, length: { maximum: 255 }
  validates :official_website, presence: true
  validates :is_active, inclusion: { in: [true, false] }
  validate :validate_museum_images_count

  def get_museum_images(width, height)
    first_image = museum_images.first
    first_image.variant(resize: "#{width}x#{height}^", gravity: 'center', extent: "#{width}x#{height}").processed
  end

  private

  def validate_museum_images_count
    if museum_images.attached? && museum_images.length > 4
      errors.add(:museum_images, "は最大4つまでです")
    end
  end
end