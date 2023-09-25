class Museum < ApplicationRecord
  has_many :exhibitions, dependent: :destroy
  has_many :bookmark_museums, dependent: :destroy
  has_many :members, through: :bookmark_museums

  has_many_attached :museum_images

  validates :name, presence: true, uniqueness: true
  validates :introduction, presence: true, length: { maximum: 255 }
  validates :official_website, presence: true, length: { maximum: 255 }
  validates :is_active, inclusion: { in: [true, false] }

  def get_museum_images(width, height)
    first_image = museum_images.first
    first_image.variant(resize: "#{width}x#{height}^", gravity: 'center', extent: "#{width}x#{height}").processed
  end

  def bookmarked_by?(member)
    bookmark_museums.exists?(member_id: member.id)
  end
end