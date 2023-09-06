class Artist < ApplicationRecord
  has_many :entry_artists, dependent: :destroy
  has_many :entered_artists, through: :entry_artists, source: :exhibition
end