class Public::BookmarkExhibitionsController < ApplicationController
  before_action :authenticate_member!
  before_action :member_is_guest?
  
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
  
  protected
  
  def member_is_guest?
    if current_member.name == "guest"
      set_flash_message("権限がありません ブロックされました")
      redirect_to top_path
    end
  end
end
