class Review < ApplicationRecord
  has_many :review_tags, dependent: :destroy
  has_many :tags, through: :review_tags
  has_many :favorites, dependent: :destroy
  has_many :favorite_reviews, through: :favorites, source: :member
  has_many :review_comments, dependent: :destroy
  belongs_to :member
  belongs_to :exhibition

  has_one_attached :review_image

  validates :body, presence: true, length: { maximum: 255 }

  def get_review_images(width, height)
    if review_image.attached?
      review_image.variant(resize_to_limit: [width, height]).processed
    end
  end

  def favorited_by?(member)
    favorites.exists?(member_id: member.id)
  end
end