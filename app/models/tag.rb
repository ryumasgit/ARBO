class Tag < ApplicationRecord
  has_many :review_tags, dependent: :destroy
  has_many :reviews, through: :review_tags

  validates :name, presence: true, uniqueness: true, length: { maximum: 50 }
end