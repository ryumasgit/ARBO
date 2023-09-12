class Public::ArtistsController < ApplicationController
  before_action :authenticate_member!
  rescue_from ActiveRecord::RecordNotFound, with: :public_event_handle_record_not_found

  def show
    @artist = Artist.find(params[:id])

    if !artist_is_active?(@artist)
      set_flash_message("権限がありません ブロックされました")
      redirect_to museums_path
      return
    end

    exhibitions = @artist.exhibitions.where(is_active: :true)
    @exhibitions = exhibitions.page(params[:page]).per(10)
  end

  protected

  def artist_is_active?(artist)
    return artist.is_active
  end
end
