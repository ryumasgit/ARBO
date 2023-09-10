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
end
