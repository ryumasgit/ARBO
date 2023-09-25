class ReviewComment < ApplicationRecord
  has_many :notifications, dependent: :destroy
  belongs_to :member
  belongs_to :review
  
  validates :comment, presence: true, length: { maximum: 140 }
end