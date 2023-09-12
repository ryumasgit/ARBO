class Public::ArtistsController < ApplicationController
  before_action :authenticate_member!

  def show
    @artist = Artist.find(params[:id])
    exhibitions = @artist.exhibitions.where(is_active: :true)
    @exhibitions = exhibitions.page(params[:page]).per(10)
  end
end
