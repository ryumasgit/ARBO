class Public::FavoritesController < ApplicationController
  before_action :authenticate_member!
  before_action :member_is_guest?, only: [:create, :destroy]
  
  def index
  end

  def create
    @review = Review.find(params[:review_id])
    favorite = current_member.favorites.new(review_id: @review.id)
    favorite.save
  end

  def destroy
    @review = Review.find(params[:review_id])
    favorite = current_member.favorites.find_by(review_id: @review.id)
    favorite.destroy
  end
end
