class Public::ExhibitionsController < ApplicationController
  before_action :authenticate_member!

  def show
    @exhibition = Exhibition.find(params[:id])
  end

  def reviews
  end
end
