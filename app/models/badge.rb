class Badge < ApplicationRecord
  has_many :earned_badges, dependent: :destroy
  has_many :members, through: :earned_badges
  has_many :notifications, dependent: :destroy

  has_one_attached :badge_image

  validates :name, presence: true, uniqueness: true, length: { maximum: 255 }
  validates :introduction, presence: true, length: { maximum: 255 }
  validates :is_active, inclusion: { in: [true, false] }

  def get_badge_image(width, height)
    badge_image.variant(resize: "#{width}x#{height}^", gravity: 'center', extent: "#{width}x#{height}").processed
  end
end