class Admin::BadgesController < ApplicationController
  before_action :get_badge_id, except: [:new, :create, :index]
  rescue_from ActiveRecord::RecordNotFound, with: :admin_badge_handle_record_not_found

  def new
    @badge = Badge.new
  end

  def create
    @badge = Badge.new(badge_params)

    # 画像データがない場合は保存禁止
    if params[:badge][:badge_image].nil?
      set_flash_message("画像が最低1つは必要です")
      redirect_to new_admin_badge_path
    elsif @badge.save
      set_flash_message("バッジの作成に成功しました")
      redirect_to admin_badge_path(@badge)
    else
      set_flash_message("バッジの作成に失敗しました")
      render :new
    end
  end

  def index
    @badges = Badge.page(params[:page]).per(10)
  end

  def show
  end

  def edit
  end

  def update
    @original_badge = Badge.find(params[:id])

    if @badge.update(badge_params)
      set_flash_message("バッジ情報の保存に成功しました")
      redirect_to admin_badge_path(@badge)
    else
      copy_error_attributes_from_original_badge
      set_flash_message("バッジ情報の保存に失敗しました")
      render :edit
    end
  end

  def destroy
    if @badge.destroy
      set_flash_message("バッジの削除に成功しました")
      redirect_to admin_badges_path
    else
      set_flash_message("バッジの削除に失敗しました")
      render :edit
    end
  end

  def earned
  end

  protected

  def badge_params
    params.require(:badge).permit(:badge_image, :name, :introduction, :is_active)
  end

  def get_badge_id
    @badge = Badge.find(params[:id])
  end

  def copy_error_attributes_from_original_badge
   # エラー箇所に元のデータを代入する
    @original_badge.attributes.each do |attr, value|
      @badge[attr] = value unless @badge.errors[attr].empty?
    end
  end
end