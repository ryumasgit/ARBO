class Admin::ExhibitionsController < ApplicationController
  before_action :get_exhibition_id, except: [:index]

  def new
  end

  def create
  end

  def show
  end

  def index
  end

  def edit
  end

  def update
    @original_exhibition = Exhibition.find(params[:id])
    if @exhibition.update(exhibition_params)
      flash[:notice] = "展示会情報の保存に成功しました"
      redirect_to admin_exhibition_path(@exhibition)
    else
      # エラー箇所に元のデータを代入する
      @original_exhibition.attributes.each do |attr, value|
        @exhibition[attr] = value unless @exhibition.errors[attr].empty?
      end
      flash[:notice] = "展示会情報の保存に失敗しました"
      render :edit
    end
  end

  def destroy
    delete_exhibition_images
    if @exhibition.destroy
      flash[:notice] = "展示会情報の削除に成功しました"
      redirect_to admin_exhibitions_path
    else
      flash[:notice] = "展示会情報の削除に失敗しました"
      render :edit
    end
  end

  protected

  def exhibition_params
    params.require(:exhibition).permit(:exhibition_images, :name, :introduction, :official_website, :is_active)
  end

  def get_exhibition_id
    @exhibition = Exhibition.find(params[:id])
  end

  def delete_exhibition_images
    exhibition_images.each do |image|
      image.purge
    end
  end
end
