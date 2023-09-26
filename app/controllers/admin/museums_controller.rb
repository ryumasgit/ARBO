class Admin::MuseumsController < ApplicationController
  before_action :get_museum_id, except: [:new, :create, :index]
  rescue_from ActiveRecord::RecordNotFound, with: :admin_event_handle_record_not_found

  def new
    @museum = Museum.new
  end

  def create
    @museum = Museum.new(museum_params)

    if validate_museum_images_creation
      redirect_to new_admin_museum_path
      return
    end

    if @museum.save
      set_flash_message("美術館の作成に成功しました")
      redirect_to admin_museum_path(@museum)
    else
      set_flash_message("美術館の作成に失敗しました")
      render :new
    end
  end

  def show
    exhibitions = @museum.exhibitions.where(is_active: :true)
    @exhibitions = exhibitions.page(params[:page])
  end

  def index
    @museums = Museum.page(params[:page])
    @exhibitions = Exhibition.page(params[:page])
    @artists = Artist.page(params[:page])
  end

  def edit
  end

  def update
    @original_museum = Museum.find(params[:id])

    if validate_museum_images_update
      redirect_to edit_admin_museum_path(@museum)
      return
    end

    museum_images_delete
    
    if @museum.update(museum_params)
      set_flash_message("美術館情報の保存に成功しました")
      redirect_to admin_museum_path(@museum)
    else
      copy_error_attributes_from_original_museum
      set_flash_message("美術館情報の保存に失敗しました")
      render :edit
    end
  end

  def destroy
    museum_images_all_delete
    
    if @museum.destroy
      set_flash_message("美術館の削除に成功しました")
      redirect_to admin_museums_path
    else
      set_flash_message("美術館の削除に失敗しました")
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

  # 画像登録数規制（新規作成時）
  def validate_museum_images_creation
    if params[:museum][:museum_images].nil?
      flash[:alert] = "画像は最低1つは必要です"
    elsif params[:museum][:museum_images].length > 4
      flash[:alert] = "画像は最大4つまでです"
    end
  end

  # 画像登録数規制（編集時）
  def validate_museum_images_update
    if params[:museum][:museum_images].present? && params[:museum][:museum_images].length > 4
      flash[:alert] = "画像は最大4つまでです"
    elsif params[:museum][:museum_image_id].present? && params[:museum][:museum_image_id].count == @museum.museum_images.count
      flash[:alert] = "画像は最低1つは必要です"
    end
  end

  # 選択された画像ファイルを削除
  def museum_images_delete
    if params[:museum][:museum_image_id].present?
      params[:museum][:museum_image_id].each do |image_id|
        image = @museum.museum_images.find(image_id)
        image.purge
      end
    end
  end

  # エラー箇所に元のデータを代入する
  def copy_error_attributes_from_original_museum
    @original_museum.attributes.each do |attr, value|
      @museum[attr] = value unless @museum.errors[attr].empty?
    end
  end

  # 画像ファイルを全削除
  def museum_images_all_delete
    @museum.museum_images.each do |image|
      image.purge
    end
  end
end