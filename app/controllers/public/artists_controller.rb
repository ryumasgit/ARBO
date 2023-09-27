class Public::ArtistsController < ApplicationController
  before_action :authenticate_member!
  rescue_from ActiveRecord::RecordNotFound, with: :public_event_handle_record_not_found

  def show
    @artist = Artist.find(params[:id])

    return artist_not_active_redirect unless @artist.is_active?

    exhibitions = @artist.exhibitions.where(is_active: :true)
    @exhibitions = exhibitions.page(params[:page])
  end

  protected

  def artist_not_active_redirect
    set_flash_message("指定されたURLは見つかりませんでした、現在非公開の可能性があります。")
    redirect_to museums_path
  end
end
