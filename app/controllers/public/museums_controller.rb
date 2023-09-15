class Public::MuseumsController < ApplicationController
  before_action :authenticate_member!
  rescue_from ActiveRecord::RecordNotFound, with: :public_event_handle_record_not_found

  def show
    @museum = Museum.find(params[:id])

    return museum_not_active_redirect unless museum_is_active?(@museum)

    exhibitions = @museum.exhibitions.where(is_active: :true)
    @exhibitions = exhibitions.page(params[:page]).per(10)
  end

  def index
    @museums = Museum.where(is_active: true).page(params[:page]).per(10)
    @exhibitions = Exhibition.where(museum_id: @museums.pluck(:id), is_active: true)
    @artists = Artist.where(is_active: true).page(params[:page]).per(10)
  end

  protected

  def museum_not_active_redirect
    set_flash_message("権限がありません ブロックされました")
    redirect_to museums_path
  end

  def museum_is_active?(museum)
    museum.is_active
  end
end
