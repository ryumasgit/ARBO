class Admin::MuseumsController < ApplicationController
  before_action :get_museum_id, except: [:index]

  def new
  end

  def create
  end

  def show
  end

  def index
    @museums = Museum.page(params[:page]).per(10)
    @exhibitions = Exhibition.page(params[:page]).per(10)
    @artists = Artist.page(params[:page]).per(10)
  end

  def edit
  end

  def update
  end

  def destroy
  end

  protected

  def get_museum_id
    @museum = Museum.find(params[:id])
  end
end
