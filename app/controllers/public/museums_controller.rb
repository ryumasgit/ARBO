class Public::MuseumsController < ApplicationController
  before_action :authenticate_member!

  def show
    @museum = Museum.find(params[:id])
    exhibitions = @museum.exhibitions.where(is_active: :true)
    @exhibitions = exhibitions.page(params[:page]).per(10)
  end

  def index
    @museums = Museum.where(is_active: true).page(params[:page]).per(10)
    @exhibitions = Exhibition.where(museum_id: @museums.pluck(:id), is_active: true)
    @artists = Artist.where(is_active: true).page(params[:page]).per(10)
  end
end
