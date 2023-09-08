class Admin::RelationshipsController < ApplicationController

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
    @member = Member.find(params[:member_id])
  end
end
