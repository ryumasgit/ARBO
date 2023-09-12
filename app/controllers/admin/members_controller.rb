class Admin::MembersController < ApplicationController
  before_action :get_member_id, except: [:index]

  def show
    redirect_if_member_not_found(@member)
  end

  def index
    @members = Member.page(params[:page]).per(10)
  end

  def edit
  end

  def update
    @original_member = Member.find(params[:id])
    
    if @member.update(member_params)
      set_flash_message("メンバー情報の保存に成功しました")
      redirect_to admin_member_path(@member)
    else
      copy_error_attributes_from_original_member
      set_flash_message("メンバー情報の保存に失敗しました")
      render :edit
    end
  end

  def destroy
    unless is_guest?
      if @member.destroy
        set_flash_message("メンバーの削除に成功しました")
        redirect_to admin_members_path
      else
        set_flash_message("メンバーの削除に失敗しました")
        render :edit
      end
    else
      set_flash_message("このメンバーは削除できません")
      render :edit
    end
  end

  protected

  def member_params
    params.require(:member).permit(:member_image, :name, :introduction, :email, :is_active)
  end

  def get_member_id
    @member = Member.find(params[:id])
  end

  def is_guest?
    @member.name == "guest"
  end

  def redirect_if_member_not_found(member)
    if member.nil?
      set_flash_message("メンバーが見つかりません")
      redirect_to admin_root_path
    end
  end

  def copy_error_attributes_from_original_member
   # エラー箇所に元のデータを代入する
    @original_member.attributes.each do |attr, value|
      @member[attr] = value unless @member.errors[attr].empty?
    end
  end
end
