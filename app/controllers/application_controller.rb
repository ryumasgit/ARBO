class ApplicationController < ActionController::Base
  before_action :check_admin_access
  before_action :prevent_concurrent_sessions_to_administrators
  before_action :prevent_concurrent_sessions_to_memberstrators

  private

  def prevent_concurrent_sessions_to_administrators
    if request.path == '/admin/sign_in' && member_signed_in?
      # メンバーがログインしている場合、管理者のアクセスを制限
      flash[:notice] = "ブロックされました ログアウト後にもう一度お確かめください"
      redirect_to root_path
    end
  end

  def prevent_concurrent_sessions_to_memberstrators
    if request.path == '/members/sign_in' && admin_signed_in?
      # 管理者がログインしている場合、一般ユーザーのアクセスを制限
      flash[:notice] = "ブロックされました ログアウト後にもう一度お確かめください"
      redirect_to admin_root_path
    end
  end

  def check_admin_access
    if admin_controller? && !admin_signed_in? && request.path != '/admin/sign_in'
      flash[:notice] = "権限がありません ブロックされました"
      redirect_to root_path
    end
  end

  def admin_controller?
    self.class.to_s.start_with?("Admin::")
  end

  def set_flash_message(message)
    flash[:notice] = message
  end

  def public_event_handle_record_not_found
    set_flash_message("指定されたURLは見つかりませんでした、現在非公開の可能性があります。")
    redirect_to museums_path
    return
  end

  def admin_event_handle_record_not_found
    set_flash_message("指定されたURLは見つかりませんでした、現在非公開の可能性があります。")
    redirect_to admin_museums_path
    return
  end

  def public_badge_handle_record_not_found
    set_flash_message("指定されたURLは見つかりませんでした、現在非公開の可能性があります。")
    redirect_to member_my_page_path(member_member_name: current_member.name)
    return
  end

  def admin_badge_handle_record_not_found
    set_flash_message("指定されたURLは見つかりませんでした、現在非公開の可能性があります。")
    redirect_to admin_badges_path
    return
  end

  def public_member_handle_record_not_found
    set_flash_message("指定されたURLは見つかりませんでした、現在非公開の可能性があります。")
    redirect_to member_my_page_path(member_member_name: current_member.name)
    return
  end

  def admin_member_handle_record_not_found
    set_flash_message("指定されたURLは見つかりませんでした、現在非公開の可能性があります。")
    redirect_to admin_members_path
    return
  end

  def public_review_handle_record_not_found
    set_flash_message("指定されたURLは見つかりませんでした、現在非公開の可能性があります。")
    redirect_to reviews_path
    return
  end

  def admin_review_handle_record_not_found
    set_flash_message("指定されたURLは見つかりませんでした、現在非公開の可能性があります。")
    redirect_to admin_reviews_path
    return
  end

  def public_review_comment_handle_record_not_found
    set_flash_message("指定されたURLは見つかりませんでした、現在非公開の可能性があります。")
    redirect_to reviews_path
    return
  end

  def admin_review_comment_handle_record_not_found
    set_flash_message("指定されたURLは見つかりませんでした、現在非公開の可能性があります。")
    redirect_to admin_reviews_path
    return
  end

  def member_is_guest?
    if current_member.is_guest?
      set_flash_message("権限がありません ブロックされました")
      redirect_to root_path
    end
  end

  # バッジ付与
  def badge_condition_met(member)
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