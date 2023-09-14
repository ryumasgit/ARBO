class Report < ApplicationRecord
  belongs_to :member
  
  validates :total_favorited, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :museum_visits, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :exhibition_visits, presence: true, numericality: { greater_than_or_equal_to: 0 }
end