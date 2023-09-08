class Badge < ApplicationRecord
  has_many :earned_badges, dependent: :destroy
  has_many :members, through: :earned_badges
  
  has_one_attached :badge_image
  
  validates :badge_name, presence: true, uniqueness: true
  validates :introduction, presence: true, length: { maximum: 255 }
  
  def get_badge_image(width, height)
    if badge_image.attached?
      badge_image.variant(resize_to_limit: [width, height]).processed
    else
      ActionController::Base.helpers.asset_path("default_badge_image.jpeg")
    end
  end
end