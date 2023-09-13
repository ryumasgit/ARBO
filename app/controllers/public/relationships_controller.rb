class Public::RelationshipsController < ApplicationController
  before_action :authenticate_member!
  before_action :get_member

  def create
    name = params[:member_member_name]
    unless name == "guest"
      current_member.follow(name)
    else
      set_flash_message("このユーザーはフォローできません")
      redirect_to member_my_page_path(member_member_name: current_member.name)
    end
  end

  def destroy
    name = params[:member_member_name]
    current_member.unfollow(name)
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
    member = Member.page(params[:page]).per(10)
    @member = member.find_by(name: params[:member_member_name])
  end
end
