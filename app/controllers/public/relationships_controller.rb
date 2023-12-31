class Public::RelationshipsController < ApplicationController
  before_action :authenticate_member!
  before_action :get_member
  before_action :member_is_guest?, only: [:create, :destroy]
  before_action :get_followed_member_name, only: [:create, :destroy]

  def create
    current_member.follow(@followed_member_name)
    current_member.create_notification_follow!(current_member, @followed_member_name)
    followed_member_id = Member.find_by(name: @followed_member_name)
    badge_condition_met(followed_member_id)
  end

  def destroy
    current_member.unfollow(@followed_member_name)
  end

  def follows
    get_member
    @members = @member.followings.page(params[:page])
  end

  def followers
    get_member
    @members = @member.followers.page(params[:page])
  end

  private

  def get_member
    @member = Member.find_by(name: params[:member_member_name])
    if @member.nil?
      set_flash_message("指定されたURLは見つかりませんでした。")
      redirect_to member_my_page_path(member_member_name: current_member.name)
    end
  end


  def get_followed_member_name
    @followed_member_name = params[:member_member_name]
    member = Member.find_by(name: @followed_member_name)
    if member.is_guest?
      set_flash_message("このユーザーはフォローできません")
      redirect_to member_my_page_path(member_member_name: current_member.name)
    end
  end
end
