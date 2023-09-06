class Tag < ApplicationRecord
  has_many :member_tags, dependent: :destroy
  has_many :members, through: :member_tags
  has_many :review_tags, dependent: :destroy
  has_many :reviews, through: :review_tags
  
  validates :tag_name, presence: true, uniqueness: true, length: { maximum: 25 }
end