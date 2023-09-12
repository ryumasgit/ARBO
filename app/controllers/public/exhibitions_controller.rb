class Public::ExhibitionsController < ApplicationController
  before_action :authenticate_member!
  rescue_from ActiveRecord::RecordNotFound, with: :public_event_handle_record_not_found

  def show
    @exhibition = Exhibition.find(params[:id])

    if !exhibition_is_active?(@exhibition)
      set_flash_message("権限がありません ブロックされました")
      redirect_to museums_path
      return
    end

    artists = @exhibition.artists.where(is_active: :true)
    @artists = artists.page(params[:page]).per(10)
  end

  def reviews
  end

  protected

  def exhibition_is_active?(exhibition)
    return exhibition.is_active
  end
end
