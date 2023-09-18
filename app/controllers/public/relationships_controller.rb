class Public::RelationshipsController < ApplicationController
  before_action :authenticate_member!
  before_action :get_member
  before_action :member_is_guest?, only: [:create, :destroy]
  before_action :get_followed_member_name, only: [:create, :destroy]

  def create
    unless @followed_member_name == "guest"
      current_member.follow(@followed_member_name)
    else
      set_flash_message("このユーザーはフォローできません")
      redirect_to member_my_page_path(member_member_name: current_member.name)
    end
  end

  def destroy
    current_member.unfollow(@followed_member_name)
  end

  def follows
    get_member
    @members = @member.followings
  end

  def followers
    get_member
    @members = @member.followers
  end

  private

  def get_member
    @member = Member.page(params[:page]).per(10).find_by(name: params[:member_member_name])
  end


  def get_followed_member_name
    @followed_member_name = params[:member_member_name]
  end
end
