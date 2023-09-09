class Admin::ExhibitionsController < ApplicationController
  before_action :get_exhibition_id, except: [:index]

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

  def get_exhibition_id
    @exhibition = Exhibition.find(params[:id])
  end
end
