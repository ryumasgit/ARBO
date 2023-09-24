class Public::FavoritesController < ApplicationController
  before_action :authenticate_member!
  before_action :member_is_guest?
  before_action :get_review_id

  def create
    favorite = current_member.favorites.new(review_id: @review.id)
    favorite.save
    @review.create_notification_favorite!(current_member)
    BadgeJob.perform_later(@review.member)
  end

  def destroy
    favorite = current_member.favorites.find_by(review_id: @review.id)
    favorite.destroy
  end

  protected

  def get_review_id
    @review = Review.find(params[:review_id])
  end
end
