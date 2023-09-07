class Public::MembersController < ApplicationController
  before_action :authenticate_member!

  def show
    @member = Member.find_by(member_name: params[:member_member_name])
    redirect_if_member_not_found(@member)
  end

  def edit
  end

  def update
  end

  def confirm_withdraw
  end

  def withdraw
  end
  
  protected
  
  def redirect_if_member_not_found(member)
    if member.nil?
      flash[:alert] = "メンバーが見つかりません。"
      redirect_to root_path
    end
  end
end
