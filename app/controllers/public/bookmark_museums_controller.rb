class Public::BookmarkMuseumsController < ApplicationController
  before_action :authenticate_member!
  before_action :member_is_guest?, only: [:create, :destroy]

  def create
    @museum = Museum.find(params[:museum_id])
    bookmark_museum = current_member.bookmark_museums.new(museum_id: @museum.id)
    bookmark_museum.save
    bookmark_museum_count
  end

  def index
    @bookmark_museums = current_member.museums.where(is_active: :true)
                                              .page(params[:page]).per(20)
  end

  def destroy
    @museum = Museum.find(params[:museum_id])
    bookmark_museum = current_member.bookmark_museums.find_by(museum_id: @museum.id)
    bookmark_museum.destroy
    bookmark_museum_count
  end
  
  def bookmark_museum_count
    @bookmark_museum_counts = BookmarkMuseum.joins(:member).where(museum_id: @museum.id, members: { is_active: true }).count
  end
end
