class Admin::MuseumsController < ApplicationController
  before_action :get_museum_id, except: [:index]

  def new
  end

  def create
  end

  def show
  end

  def index
    @museums = Museum.page(params[:page]).per(10)
    @exhibitions = Exhibition.page(params[:page]).per(10)
    @artists = Artist.page(params[:page]).per(10)
  end

  def edit
  end

  def update
    @original_museum = Museum.find(params[:id])
    if @museum.update(museum_params)
      flash[:notice] = "美術館情報の保存に成功しました"
      redirect_to admin_museum_path(@museum)
    else
      # エラー箇所に元のデータを代入する
      @original_museum.attributes.each do |attr, value|
        @museum[attr] = value unless @museum.errors[attr].empty?
      end
      flash[:notice] = "美術館情報の保存に失敗しました"
      render :edit
    end
  end

  def destroy
    delete_museum_images(@museum)
    if @museum.destroy
      flash[:notice] = "美術館情報の削除に成功しました"
      redirect_to admin_museums_path
    else
      flash[:notice] = "美術館情報の削除に失敗しました"
      render :edit
    end
  end

  protected

  def museum_params
    params.require(:museum).permit(:museum_images, :name, :introduction, :official_website, :is_active)
  end

  def get_museum_id
    @museum = Museum.find(params[:id])
  end

  def delete_museum_images(museum)
    museum.museum_images.each do |image|
      image.purge
    end
  end
end
