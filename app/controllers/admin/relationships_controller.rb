class Admin::RelationshipsController < ApplicationController

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
    @member = Member.find_by(id: params[:member_id])
  end
end