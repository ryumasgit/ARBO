class BookmarkExhibition < ApplicationRecord
  belongs_to :member
  belongs_to :exhibition
end