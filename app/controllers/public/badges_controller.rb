class Public::BadgesController < ApplicationController
  before_action :authenticate_member!
  # rescue_from ActiveRecord::RecordNotFound, with: :public_badge_handle_record_not_found

  def show
    @badge = Badge.find(params[:id])
  end
end