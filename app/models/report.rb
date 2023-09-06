class Report < ApplicationRecord
  has_many :earned_badges, dependent: :destroy
  has_many :badges, through: :earned_badges
  belongs_to :member
  
  validates :total_favorited, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :museum_visits, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :exhibition_visits, presence: true, numericality: { greater_than_or_equal_to: 0 }
end