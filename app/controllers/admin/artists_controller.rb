class Admin::ArtistsController < ApplicationController
  before_action :get_artist_id, except: [:index]

  def new
  end

  def create
  end

  def show
  end

  def index
  end

  def edit
  end

  def update
  end

  def destroy
  end

  protected

  def get_artist_id
    @artist = Artist.find(params[:id])
  end
end
