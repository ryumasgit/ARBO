class Admin::RelationshipsController < ApplicationController
  before_action :get_member

  def follows
    @members = @member.followings.page(params[:page])
  end

  def followers
    @members = @member.followers.page(params[:page])
  end

  private

  def get_member
    @member = Member.find_by(id: params[:member_id])
    if @member.nil?
      set_flash_message("指定されたメンバーが見つかりませんでした。")
      redirect_to admin_members_path
    end
  end
end