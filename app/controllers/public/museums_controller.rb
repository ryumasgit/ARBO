class Public::MuseumsController < ApplicationController
  before_action :authenticate_member!

  def show
    @museum = Museum.find(params[:id])
  end

  def index
    @museums = Museum.page(params[:page]).per(10)
    @exhibitions = Exhibition.page(params[:page]).per(10)
  end
end
