class Review < ApplicationRecord
  has_many :review_tags, dependent: :destroy
  has_many :tags, through: :review_tags
  has_many :favorites, dependent: :destroy
  has_many :favorite_reviews, through: :favorites, source: :member
  belongs_to :member
  belongs_to :exhibition

  has_many_attached :review_images

  validates :title, presence: true, length: { maximum: 50 }
  validates :body, length: { maximum: 255 }
  validate :validate_review_images_count

  def get_review_images(width, height)
    if review_images.attached?
      review_images.variant(resize_to_limit: [width, height]).processed
    end
  end

  private

  def validate_review_images_count
    if review_images.attached? && review_images.length > 4
      errors.add(:review_images, "は最大4つまでです")
    end
  end
end