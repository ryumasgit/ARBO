class BadgeJob < ApplicationJob
  queue_as :default

  def perform(member)
    if member.is_guest
      return
    end
    # バッジ条件と対応するバッジIDのハッシュ
    badge_conditions = {
      first_review_badge_condition_met?: { badge_id: 1, active_check: true },
      first_comment_badge_condition_met?: { badge_id: 2, active_check: true },
      first_follower_badge_condition_met?: { badge_id: 3, active_check: true },
      first_favorited_badge_condition_met?: { badge_id: 4, active_check: true },
      museum_enthusiast_badge_condition_met?: { badge_id: 5, active_check: true },
      exhibition_enthusiast_badge_condition_met?: { badge_id: 6, active_check: true }
    }

    # 各条件をチェックし、条件が満たされた場合にバッジを付与
    badge_conditions.each do |condition_method, options|
      if options[:active_check] && send(condition_method, member)
        badge = Badge.find_by(id: options[:badge_id], is_active: true)
        if badge.present?
          member.earned_badges.create(badge_id: options[:badge_id])
          # バッジを付与した後に通知を作成
          temp = Notification.where(["visitor_id = ? and visited_id = ? and badge_id = ? and action = ? ", member.id, member.id, options[:badge_id], 'badge'])
          if temp.blank?
            notification = member.active_notifications.new(
              visited_id: member.id,
              badge_id: options[:badge_id],
              action: 'badge'
            )
            notification.save if notification.valid?
          end
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
end
