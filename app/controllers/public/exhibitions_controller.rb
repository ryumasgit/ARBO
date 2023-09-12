class Public::ExhibitionsController < ApplicationController
  before_action :authenticate_member!

  def show
    @exhibition = Exhibition.find(params[:id])
    artists = @exhibition.artists.where(is_active: :true)
    @artists = artists.page(params[:page]).per(10)
  end

  def reviews
  end
end
