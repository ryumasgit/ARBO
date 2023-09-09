module Admin::BadgesHelper
  
  def badge_is_active_display(badge)
    if badge.is_active == true
      "公開中"
    else
      "下書き"
    end
  end
end
