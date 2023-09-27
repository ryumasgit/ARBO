class Public::ExhibitionsController < ApplicationController
  before_action :authenticate_member!
  rescue_from ActiveRecord::RecordNotFound, with: :public_event_handle_record_not_found

  def show
    @exhibition = Exhibition.find(params[:id])

    return exhibition_not_active_redirect unless @exhibition.is_active?

    artists = @exhibition.artists.where(is_active: :true)
    @artists = artists.page(params[:page])
  end

  protected

  def exhibition_not_active_redirect
    set_flash_message("指定されたURLは見つかりませんでした、現在非公開の可能性があります。")
    redirect_to museums_path
  end
end
