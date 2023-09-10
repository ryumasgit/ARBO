class Admin::ArtistsController < ApplicationController
  before_action :get_artist_id, except: [:new, :index]

  def new
    @artist = Artist.new
  end

  def create
    @artist = Artist.new(artist_params)
    if @artist.save
      flash[:notice] = "アーティストの作成に成功しました"
      redirect_to admin_artist_path(@artist)
    else
      flash[:notice] = "アーティストの作成に失敗しました"
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    @original_artist = Artist.find(params[:id])
    if @artist.update(artist_params)
      flash[:notice] = "アーティスト情報の保存に成功しました"
      redirect_to admin_artist_path(@artist)
    else
      # エラー箇所に元のデータを代入する
      @original_artist.attributes.each do |attr, value|
        @artist[attr] = value unless @artist.errors[attr].empty?
      end
      flash[:notice] = "アーティスト情報の保存に失敗しました"
      render :edit
    end
  end

  def destroy
    delete_artist_images
    if @artist.destroy
      flash[:notice] = "アーティストの削除に成功しました"
      redirect_to admin_museums_path
    else
      flash[:notice] = "アーティストの削除に失敗しました"
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

  def delete_artist_images
    @artist.artist_images.each do |image|
      image.purge
    end
  end
end
