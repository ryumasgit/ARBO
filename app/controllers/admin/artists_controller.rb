class Admin::ArtistsController < ApplicationController
  before_action :get_artist_id, except: [:index]

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
    if @artist.destroy
      flash[:notice] = "アーティスト情報の削除に成功しました"
      redirect_to admin_artists_path
    else
      flash[:notice] = "アーティスト情報の削除に失敗しました"
      render :edit
    end
  end

  protected

  def artist_params
    params.require(:artist).permit(:artist_images, :name, :introduction, :is_active)
  end
  def get_artist_id
    @artist = Artist.find(params[:id])
  end
end
