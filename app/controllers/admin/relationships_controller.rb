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
    @member = Member.where(id: params[:member_id]).page(params[:page]).per(10)
  end
end