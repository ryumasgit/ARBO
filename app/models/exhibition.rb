class Exhibition < ApplicationRecord
  has_many :reviews, dependent: :destroy
  has_many :bookmark_exhibitions, dependent: :destroy
  has_many :members, through: :bookmark_exhibitions
  has_many :entry_artists, dependent: :destroy
  has_many :artists, through: :entry_artists
  belongs_to :museum

  has_many_attached :exhibition_images

  validates :name, presence: true
  validates :introduction, presence: true, length: { maximum: 255 }
  validates :official_website, presence: true, length: { maximum: 255 }
  validates :is_active, inclusion: { in: [true, false] }

  def get_exhibition_images(width, height)
    first_image = exhibition_images.first
    first_image.variant(resize: "#{width}x#{height}^", gravity: 'center', extent: "#{width}x#{height}").processed
  end

  def bookmarked_by?(member)
    bookmark_exhibitions.exists?(member_id: member.id)
  end
end