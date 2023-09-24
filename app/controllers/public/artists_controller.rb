class Public::ArtistsController < ApplicationController
  before_action :authenticate_member!
  rescue_from ActiveRecord::RecordNotFound, with: :public_event_handle_record_not_found

  def show
    @artist = Artist.find(params[:id])

    return artist_not_active_redirect unless artist_is_active?(@artist)

    exhibitions = @artist.exhibitions.where(is_active: :true)
    @exhibitions = exhibitions.page(params[:page])
  end

  protected

  def artist_not_active_redirect
    set_flash_message("権限がありません ブロックされました")
    redirect_to museums_path
  end
  
  def artist_is_active?(artist)
    artist.is_active
  end
end
