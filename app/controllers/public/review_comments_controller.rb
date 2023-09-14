class Public::ReviewCommentsController < ApplicationController
  before_action :authenticate_member!
  before_action :member_is_guest?, only: [:create, :destroy]

  def index
  end

  def create
  end

  def destroy
  end
end
