module Admin::MembersHelper

  def member_is_active_display(member)
    if member.is_active == true
      "入会"
    else
      "退会"
    end
  end
end
