class Public::BookmarkMuseumsController < ApplicationController
  before_action :authenticate_member!
  before_action :member_is_guest?

  def index
  end

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
  
  protected
  
  def member_is_guest?
    if current_member.name == "guest"
      set_flash_message("権限がありません ブロックされました")
      redirect_to top_path
    end
  end
end
