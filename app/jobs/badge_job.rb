class BadgeJob < ApplicationJob
  queue_as :default

  def perform(member)
    if first_review_badge_condition_met?(member)
      badge = member.earned_badges.new(badge_id: 1)
      badge.save
    end
    if first_comment_badge_condition_met?(member)
      badge = member.earned_badges.new(badge_id: 2)
      badge.save
    end
  end

  private

  def first_review_badge_condition_met?(member)
    if member.reviews.present? && !member.badges.exists?(id: 1)
      return true
    end
    false
  end

  def first_comment_badge_condition_met?(member)
    if member.review_comments.present? && !member.badges.exists?(id: 2)
      return true
    end
    false
  end
end
