class EarnedBadge < ApplicationRecord
  belongs_to :member
  belongs_to :badge
end