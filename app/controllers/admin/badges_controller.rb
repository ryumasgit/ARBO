class Admin::BadgesController < ApplicationController
  before_action :get_badge_id, except: [:index]

  def new
  end

  def create
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
      flash[:notice] = "バッジ情報の保存に成功しました"
      redirect_to admin_badge_path(@badge)
    else
      # エラー箇所に元のデータを代入する
      @original_badge.attributes.each do |attr, value|
        @badge[attr] = value unless @badge.errors[attr].empty?
      end
      flash[:notice] = "バッジ情報の保存に失敗しました"
      render :edit
    end
  end

  def destroy
    if @badge.destroy
      flash[:notice] = "バッジの削除に成功しました"
      redirect_to admin_badges_path
    else
      flash[:notice] = "バッジの削除に失敗しました"
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
end
