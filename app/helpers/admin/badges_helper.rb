module Admin::BadgesHelper
  
  def badge_is_active_display(badge)
    if badge.is_active == true
      "公開"
    else
      "非公開"
    end
  end
end
