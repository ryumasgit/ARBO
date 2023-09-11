class Admin::ExhibitionsController < ApplicationController
  before_action :get_exhibition_id, except: [:new, :create, :index]

  def new
    @exhibition = Exhibition.new
  end

  def create
    @exhibition = Exhibition.new(exhibition_params)

    if params[:exhibition][:exhibition_images].nil?
      set_flash_message("画像は最低1つは必要です")
      redirect_to new_admin_exhibition_path
      return
    end

    if params[:exhibition][:exhibition_images].length > 4
      set_flash_message("画像は最大4つまでです")
      redirect_to new_admin_exhibition_path
      return
    end

    if @exhibition.save
      # 選択されたアーティストを関連付ける
      artist_ids = params[:exhibition][:artist_ids]
      if artist_ids.present?
        artist_ids.each do |artist_id|
          EntryArtist.create(exhibition_id: @exhibition.id, artist_id: artist_id)
        end
      end
      set_flash_message("展示会の作成に成功しました")
      redirect_to admin_exhibition_path(@exhibition)
    else
      set_flash_message("展示会の作成に失敗しました")
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    @original_exhibition = Exhibition.find(params[:id])

    if exhibition_images_over_count?
      set_flash_message("画像は最大4つまでです")
      redirect_to edit_admin_exhibition_path(@exhibition)
      return
    end
    
    if exhibition_images_count_zero?
      set_flash_message("画像は最低1つは必要です")
      redirect_to edit_admin_exhibition_path(@exhibition)
      return
    end
    
    exhibition_images_delete
    if @exhibition.update(exhibition_params)
      set_flash_message("展示会情報の保存に成功しました")
      redirect_to admin_exhibition_path(@exhibition)
    else
      copy_error_attributes_from_original_exhibition
      set_flash_message("展示会情報の保存に失敗しました")
      render :edit
    end
  end

  def destroy
    exhibition_images_all_delete
    if @exhibition.destroy
      set_flash_message("展示会の削除に成功しました")
      redirect_to admin_museums_path
    else
      set_flash_message("展示会の削除に失敗しました")
      render :edit
    end
  end

  protected

  def exhibition_params
    params.require(:exhibition).permit(:museum_id, :artist_ids, :name, :introduction, :official_website, :is_active, exhibition_images: [] )
  end

  def get_exhibition_id
    @exhibition = Exhibition.find(params[:id])
  end

  # 画像登録数規制（最大）
  def exhibition_images_over_count?
    params[:exhibition][:exhibition_images].present? && params[:exhibition][:exhibition_images].length > 4
  end

  # 画像登録数規制（0）
  def exhibition_images_count_zero?
    params[:exhibition][:exhibition_image_id].present? && params[:exhibition][:exhibition_image_id].count == @exhibition.exhibition_images.count
  end

  # 選択された画像ファイルを削除
  def exhibition_images_delete
    if params[:exhibition][:exhibition_image_id].present?
      params[:exhibition][:exhibition_image_id].each do |image_id|
        image = @exhibition.exhibition_images.find(image_id)
        image.purge
      end
    end
  end

  def copy_error_attributes_from_original_exhibition
   # エラー箇所に元のデータを代入する
    @original_exhibition.attributes.each do |attr, value|
      @exhibition[attr] = value unless @exhibition.errors[attr].empty?
    end
  end

  # 画像ファイルを全削除
  def exhibition_images_all_delete
    @exhibition.exhibition_images.each do |image|
      image.purge
    end
  end
end