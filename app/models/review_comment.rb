class ReviewComment < ApplicationRecord
  belongs_to :member
  belongs_to :review
  
  validates :comment, presence: true, length: { maximum: 140 }
end