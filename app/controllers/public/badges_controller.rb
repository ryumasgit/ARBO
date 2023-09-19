class Public::BadgesController < ApplicationController
  before_action :authenticate_member!
  # rescue_from ActiveRecord::RecordNotFound, with: :public_badge_handle_record_not_found

  def show
    @badge = Badge.find(params[:id])
  end

  def check_condition
    @review = session[:check_condition]
    if badge_condition_met?
      set_flash_message("レビューの作成に成功しました 新たなバッジを獲得しました")
      redirect_to review_path(@review)
    else
      set_flash_message("レビューの作成に成功しました")
      redirect_to review_path(@review)
    end
  end

  private

  def badge_condition_met?
    if current_member.reviews.present? && !current_member.badges.exists?(id: 1)
      badge = current_member.earned_badges.new(badge_id: 1)
      if badge.save
        return true
      end
    end
    false
  end
end
