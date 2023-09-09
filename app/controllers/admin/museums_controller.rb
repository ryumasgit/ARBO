class Admin::MuseumsController < ApplicationController
  def new
  end

  def create
  end

  def index
    @museums = Museum.page(params[:page]).per(10)
    @exhibitions = Exhibition.page(params[:page]).per(10)
    @artists = Artist.page(params[:page]).per(10)
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
