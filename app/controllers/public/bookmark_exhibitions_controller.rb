class Public::BookmarkExhibitionsController < ApplicationController
  before_action :authenticate_member!
  
  def index
  end

  def create
    @exhibition = Exhibition.find(params[:exhibition_id])
    bookmark_exhibition = current_member.bookmark_exhibitions.new(exhibition_id: @exhibition.id)
    bookmark_exhibition.save
  end

  def destroy
    @exhibition = Exhibition.find(params[:exhibition_id])
    bookmark_exhibition = current_member.bookmark_exhibitions.find_by(exhibition_id: @exhibition.id)
    bookmark_exhibition.destroy
  end
end
