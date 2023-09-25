class Admin::ArtistsController < ApplicationController
  before_action :get_artist_id, except: [:new, :create, :index]
  rescue_from ActiveRecord::RecordNotFound, with: :admin_event_handle_record_not_found

  def new
    @artist = Artist.new
  end

  def create
    @artist = Artist.new(artist_params)

    if params[:artist][:artist_images].nil?
      flash[:alert] = "画像は最低1つは必要です"
      redirect_to new_admin_artist_path
      return
    end

    if params[:artist][:artist_images].length > 4
      flash[:alert] = "画像は最大4つまでです"
      redirect_to new_admin_artist_path
      return
    end

    if @artist.save
      set_flash_message("アーティストの作成に成功しました")
      redirect_to admin_artist_path(@artist)
    else
      set_flash_message("アーティストの作成に失敗しました")
      render :new
    end
  end

  def show
    exhibitions = @artist.exhibitions.where(is_active: :true)
    @exhibitions = exhibitions.page(params[:page])
  end

  def edit
  end

  def update
    @original_artist = Artist.find(params[:id])

    if artist_images_count_exceeds_limit?
      flash[:alert] = "画像は最大4つまでです"
      redirect_to edit_admin_artist_path(@artist)
      return
    end

    if artist_images_count_equals_zero?
      flash[:alert] = "画像は最低1つは必要です"
      redirect_to edit_admin_artist_path(@artist)
      return
    end

    artist_images_delete
    if @artist.update(artist_params)
      set_flash_message("アーティスト情報の保存に成功しました")
      redirect_to admin_artist_path(@artist)
    else
      copy_error_attributes_from_original_artist
      set_flash_message("アーティスト情報の保存に失敗しました")
      render :edit
    end
  end

  def destroy
    artist_images_all_delete
    if @artist.destroy
      set_flash_message("アーティストの削除に成功しました")
      redirect_to admin_museums_path
    else
      set_flash_message("アーティストの削除に失敗しました")
      render :edit
    end
  end

  protected

  def artist_params
    params.require(:artist).permit(:name, :introduction, :is_active, artist_images: [])
  end

  def get_artist_id
    @artist = Artist.find(params[:id])
  end

  # 画像登録数規制（最大）
  def artist_images_count_exceeds_limit?
    params[:artist][:artist_images].present? && params[:artist][:artist_images].length > 4
  end

  # 画像登録数規制（0）
  def artist_images_count_equals_zero?
    params[:artist][:artist_image_id].present? && params[:artist][:artist_image_id].count == @artist.artist_images.count
  end

  # 選択された画像ファイルを削除
  def artist_images_delete
    if params[:artist][:artist_image_id].present?
      params[:artist][:artist_image_id].each do |image_id|
        image = @artist.artist_images.find(image_id)
        image.purge
      end
    end
  end

   # エラー箇所に元のデータを代入する
  def copy_error_attributes_from_original_artist
    @original_artist.attributes.each do |attr, value|
      @artist[attr] = value unless @artist.errors[attr].empty?
    end
  end

  # 画像ファイルを全削除
  def artist_images_all_delete
    @artist.artist_images.each do |image|
      image.purge
    end
  end
end