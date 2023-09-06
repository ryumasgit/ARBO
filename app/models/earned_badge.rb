class EarnedBadge < ApplicationRecord
  belongs_to :report
  belongs_to :badge
end