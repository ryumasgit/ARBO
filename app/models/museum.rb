class Museum < ApplicationRecord
  has_many :exhibitions, dependent: :destroy
  has_many :bookmark_museums, dependent: :destroy
  has_many :museums, through: :bookmark_museums

  has_many_attached :museum_images

  validates :museum_name, presence: true, uniqueness: true
  validates :introduction, presence: true, length: { maximum: 255 }
  validates :official_website, presence: true
  validates :is_active, presence: true, inclusion: { in: [true, false] }
  validate :validate_museum_images_count
  
  def get_museum_images(width, height)
    if museum_images.attached?
      museum_images.variant(resize_to_limit: [width, height]).processed
    else
      ActionController::Base.helpers.asset_path("default_museum_image.jpeg")
    end
  end

  private

  def validate_museum_images_count
    if museum_images.attached? && museum_images.length > 4
      errors.add(:museum_images, "は最大4つまでです")
    end
  end
end