class BadgeJob < ApplicationJob
  queue_as :default

  def perform(member)
    if member_is_guest?(member)
      return
    end
    # バッジ条件と対応するバッジIDのハッシュ
    badge_conditions = {
      first_review_badge_condition_met?: 1,
      first_comment_badge_condition_met?: 2,
      first_follower_badge_condition_met?: 3,
      first_favorited_badge_condition_met?: 4,
      museum_enthusiast_badge_condition_met?: 5,
      exhibition_enthusiast_badge_condition_met?: 6
    }

    # 各条件をチェックし、条件が満たされた場合にバッジを付与
    badge_conditions.each do |condition_method, badge_id|
      if send(condition_method, member)
        badge = member.earned_badges.new(badge_id: badge_id)
        badge.save
        # バッジを付与した後に通知を作成
        temp = Notification.where(["visitor_id = ? and visited_id = ? and badge_id = ? and action = ? ", member.id, member.id, badge_id, 'badge'])
        if temp.blank?
          notification = member.active_notifications.new(
            visited_id: member.id,
            badge_id: badge_id,
            action: 'badge'
          )
          notification.save if notification.valid?
        end
      end
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
