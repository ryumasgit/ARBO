class Public::BookmarkExhibitionsController < ApplicationController
  before_action :authenticate_member!
  before_action :member_is_guest?, only: [:create, :destroy]

  def create
    @exhibition = Exhibition.find(params[:exhibition_id])
    bookmark_exhibition = current_member.bookmark_exhibitions.new(exhibition_id: @exhibition.id)
    bookmark_exhibition.save
  end

  def index
    @bookmark_exhibitions = current_member.exhibitions.page(params[:page]).per(20)
  end

  def destroy
    @exhibition = Exhibition.find(params[:exhibition_id])
    bookmark_exhibition = current_member.bookmark_exhibitions.find_by(exhibition_id: @exhibition.id)
    bookmark_exhibition.destroy
  end
end
