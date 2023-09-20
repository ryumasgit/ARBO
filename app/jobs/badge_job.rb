class BadgeJob < ApplicationJob
  queue_as :default

  def perform(member)
    if member_is_guest?(member)
      return
    end
    if first_review_badge_condition_met?(member)
      badge = member.earned_badges.new(badge_id: 1)
      badge.save
    end
    if first_comment_badge_condition_met?(member)
      badge = member.earned_badges.new(badge_id: 2)
      badge.save
    end
    if first_follower_badge_condition_met?(member)
      badge = member.earned_badges.new(badge_id: 3)
      badge.save
    end
    if first_favorited_badge_condition_met?(member)
      badge = member.earned_badges.new(badge_id: 4)
      badge.save
    end
    if museum_enthusiast_badge_condition_met?(member)
      badge = member.earned_badges.new(badge_id: 5)
      badge.save
    end
    if exhibition_enthusiast_badge_condition_met?(member)
      badge = member.earned_badges.new(badge_id: 6)
      badge.save
    end
  end

  protected

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

  def first_follower_badge_condition_met?(member)
    if member.followers.present? && !member.badges.exists?(id: 3)
      return true
    end
    false
  end

  def first_favorited_badge_condition_met?(member)
    if member.reviews.joins(:favorites).exists? && !member.badges.exists?(id: 4)
      return true
    end
    false
  end

  def museum_enthusiast_badge_condition_met?(member)
    if calculate_total_visited_museum(member) > 4 && !member.badges.exists?(id: 5)
      return true
    end
    false
  end

  def exhibition_enthusiast_badge_condition_met?(member)
    if calculate_total_visited_exhibition(member) > 4 && !member.badges.exists?(id: 6)
      return true
    end
    false
  end

  def calculate_total_visited_museum(member)
    Museum.joins(exhibitions: {reviews: :member})
          .where(museums: { is_active: true })
          .where(members: { id: member.id })
          .distinct
          .count
  end

  def calculate_total_visited_exhibition(member)
    Exhibition.joins(reviews: :member)
          .where(exhibitions: { is_active: true })
          .where(members: { id: member.id })
          .distinct
          .count
  end
  
  def member_is_guest?(member)
    if member.is_guest == true
      return true
    end
    false
  end
end
