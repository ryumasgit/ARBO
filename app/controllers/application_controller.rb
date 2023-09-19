class ApplicationController < ActionController::Base
  before_action :check_admin_access

  private

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
    set_flash_message("指定されたURLは見つかりませんでした")
    redirect_to museums_path
    return
  end

  def admin_event_handle_record_not_found
    set_flash_message("指定されたURLは見つかりませんでした")
    redirect_to admin_museums_path
    return
  end

  def admin_badge_handle_record_not_found
    set_flash_message("指定されたURLは見つかりませんでした")
    redirect_to admin_badges_path
    return
  end

  def public_member_handle_record_not_found
    set_flash_message("指定されたURLは見つかりませんでした")
    redirect_to member_my_page_path(member_member_name: current_member.name)
    return
  end

  def admin_member_handle_record_not_found
    set_flash_message("指定されたURLは見つかりませんでした")
    redirect_to admin_members_path
    return
  end

  def public_review_handle_record_not_found
    set_flash_message("指定されたURLは見つかりませんでした")
    redirect_to reviews_path
    return
  end

  def admin_review_handle_record_not_found
    set_flash_message("指定されたURLは見つかりませんでした")
    redirect_to admin_reviews_path
    return
  end
  
  def public_review_comment_handle_record_not_found
    set_flash_message("指定されたURLは見つかりませんでした")
    redirect_to reviews_path
    return
  end
  
  def admin_review_comment_handle_record_not_found
    set_flash_message("指定されたURLは見つかりませんでした")
    redirect_to admin_reviews_path
    return
  end
  
  def member_is_guest?
    if current_member.is_guest?
      set_flash_message("権限がありません ブロックされました")
      redirect_to root_path
    end
  end
end
