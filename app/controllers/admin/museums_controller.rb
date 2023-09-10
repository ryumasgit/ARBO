class Admin::MuseumsController < ApplicationController
  before_action :get_museum_id, except: [:new, :create, :index]

  def new
    @museum = Museum.new
  end

  def create
    @museum = Museum.new(museum_params)
    if @museum.save
      flash[:notice] = "美術館の作成に成功しました"
      redirect_to admin_museum_path(@museum)
    else
      flash[:notice] = "美術館の作成に失敗しました"
      render :new
    end
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

    if museum_images_delete
      flash[:notice] = "画像が最低1つは必要です"
      redirect_to edit_admin_museum_path(@museum)
    elsif @museum.update(museum_params)
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
    museum_images_all_delete
    if @museum.destroy
      flash[:notice] = "美術館の削除に成功しました"
      redirect_to admin_museums_path
    else
      flash[:notice] = "美術館の削除に失敗しました"
      render :edit
    end
  end

  protected

  def museum_params
    params.require(:museum).permit(:name, :introduction, :official_website, :is_active, museum_images: [])
  end

  def get_museum_id
    @museum = Museum.find(params[:id])
  end

    # 選択された画像ファイルを削除
  def museum_images_delete
    if params[:museum][:museum_image_id].present?
      if params[:museum][:museum_image_id].count == @museum.museum_images.count
        return true
      else
        params[:museum][:museum_image_id].each do |image_id|
          image = @museum.museum_images.find(image_id)
          image.purge
        end
      end
    end
  end

  # 画像ファイルを全削除
  def museum_images_all_delete
    @museum.museum_images.each do |image|
      image.purge
    end
  end
end
