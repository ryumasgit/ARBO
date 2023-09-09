class EntryArtist < ApplicationRecord
  belongs_to :exhibition
  belongs_to :artist
end