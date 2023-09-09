class Badge < ApplicationRecord
  has_many :earned_badges, dependent: :destroy
  has_many :members, through: :earned_badges
  
  has_one_attached :badge_image
  
  validates :name, presence: true, uniqueness: true
  validates :introduction, presence: true, length: { maximum: 255 }
  
  def get_badge_image(width, height)
    badge_image.variant(resize: "#{width}x#{height}^", gravity: 'center', extent: "#{width}x#{height}").processed
  end
end