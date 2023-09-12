class Public::MembersController < ApplicationController
  before_action :authenticate_member!
  before_action :get_current_member, only: [:edit, :update]
  before_action :ensure_correct_member,  only: [:edit, :update, :withdraw]
  rescue_from ActiveRecord::RecordNotFound, with: :public_memeber_handle_record_not_found

  def show
    @member = Member.find_by(name: params[:member_member_name])
    redirect_if_member_not_found(@member)
  end

  def edit
  end

  def update
    @original_member = current_member

    if @member.update(member_params)
      set_flash_message("メンバー情報の保存に成功しました")
      redirect_to member_my_page_path(member_member_name: current_member.name)
    else
      copy_error_attributes_from_original_member
      set_flash_message("メンバー情報の保存に失敗しました")
      render :edit
    end
  end

  def withdraw
    if current_member.update(is_active: false)
      reset_session
      set_flash_message("退会が完了しました")
      redirect_to root_path
    else
      set_flash_message("退会に失敗しました")
      render :confirm_withdraw
    end
  end

  protected

  def member_params
    params.require(:member).permit(:member_image, :name, :introduction, :email, :is_active)
  end

  def get_current_member
    @member = current_member
  end

  def redirect_if_member_not_found(member)
    if member.nil? || member.is_active == false || member.name == "guest"
      set_flash_message("メンバーが見つかりません")
      redirect_to root_path
    end
  end

  def ensure_correct_member
    @member = Member.find_by(name: params[:member_member_name])
    unless @member == current_member
    set_flash_message("権限がありません ブロックされました")
    redirect_to root_path
    end
  end

  def copy_error_attributes_from_original_member
    # エラー箇所に元のデータを代入する
    @original_member.attributes.each do |attr, value|
      @member[attr] = value unless @member.errors[attr].empty?
      @member.introduction = @original_member.introduction
    end
  end
end
