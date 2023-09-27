class Public::MuseumsController < ApplicationController
  before_action :authenticate_member!
  rescue_from ActiveRecord::RecordNotFound, with: :public_event_handle_record_not_found

  def show
    @museum = Museum.find(params[:id])

    return museum_not_active_redirect unless @museum.is_active?

    exhibitions = @museum.exhibitions.where(is_active: :true)
    @exhibitions = exhibitions.page(params[:page])
  end

  def index
    @museums = Museum.where(is_active: true).page(params[:page])
    @exhibitions = Exhibition.where(museum_id: @museums.pluck(:id), is_active: true).page(params[:page])
    @artists = Artist.where(is_active: true).page(params[:page])
  end

  protected

  def museum_not_active_redirect
    set_flash_message("指定されたURLは見つかりませんでした、現在非公開の可能性があります。")
    redirect_to museums_path
  end
end
