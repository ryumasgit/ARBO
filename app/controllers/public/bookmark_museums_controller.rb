class Public::BookmarkMuseumsController < ApplicationController
  before_action :authenticate_member!
  before_action :member_is_guest?, only: [:create, :destroy]

  def create
    @museum = Museum.find(params[:museum_id])
    bookmark_museum = current_member.bookmark_museums.new(museum_id: @museum.id)
    bookmark_museum.save
  end

  def destroy
    @museum = Museum.find(params[:museum_id])
    bookmark_museum = current_member.bookmark_museums.find_by(museum_id: @museum.id)
    bookmark_museum.destroy
  end
end
