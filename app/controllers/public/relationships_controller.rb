class Public::RelationshipsController < ApplicationController
  before_action :authenticate_member!

  def create
    member_name = params[:member_member_name]
    current_member.follow(member_name)
    redirect_to request.referer
  end

  def destroy
    member_name = params[:member_member_name]
    current_member.unfollow(member_name)
    redirect_to request.referer
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
    @member = member.find_by(member_name: params[:member_member_name])
  end
end
