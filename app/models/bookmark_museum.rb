class BookmarkMuseum < ApplicationRecord
  belongs_to :member
  belongs_to :museum
end