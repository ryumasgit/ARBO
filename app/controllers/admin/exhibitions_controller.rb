class Admin::ExhibitionsController < ApplicationController
  before_action :get_exhibition_id, except: [:new, :create, :index]

  def new
    @exhibition = Exhibition.new
  end

  def create
    @exhibition = Exhibition.new(exhibition_params)

    # 画像データがない場合は保存禁止
    unless params[:exhibition][:exhibition_images].present?
      set_flash_message("画像が最低1つは必要です")
      redirect_to new_admin_exhibition_path
      return
    end

    if @exhibition.save
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

    if exhibition_images_delete
      set_flash_message("画像が最低1つは必要です")
      redirect_to edit_admin_exhibition_path(@exhibition)
    elsif @exhibition.update(exhibition_params)
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
    params.require(:exhibition).permit(:name, :introduction, :official_website, :is_active, exhibition_images: [] )
  end

  def get_exhibition_id
    @exhibition = Exhibition.find(params[:id])
  end

  # 選択された画像ファイルを削除かつ、全ての画像ファイルの削除禁止
  def exhibition_images_delete
    if params[:exhibition][:exhibition_image_id].present?
      if params[:exhibition][:exhibition_image_id].count == @exhibition.exhibition_images.count
        return true
      else
        params[:exhibition][:exhibition_image_id].each do |image_id|
          image = @exhibition.exhibition_images.find(image_id)
          image.purge
        end
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