class Public::ExhibitionsController < ApplicationController
  before_action :authenticate_member!
  rescue_from ActiveRecord::RecordNotFound, with: :public_event_handle_record_not_found

  def show
    @exhibition = Exhibition.find(params[:id])

    return exhibition_not_active_redirect unless exhibition_is_active?(@exhibition)

    artists = @exhibition.artists.where(is_active: :true)
    @artists = artists.page(params[:page]).per(10)
  end

  protected

  def exhibition_not_active_redirect
    set_flash_message("権限がありません ブロックされました")
    redirect_to museums_path
  end

  def exhibition_is_active?(exhibition)
    exhibition.is_active
  end
end
