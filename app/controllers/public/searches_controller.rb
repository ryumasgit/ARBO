class Public::SearchesController < ApplicationController
  before_action :authenticate_member!

  def index
    if params[:content].present?
      content = params[:content]
      @members = Member.where("name LIKE ?", "%#{content}%").page(params[:page]).per(50)
      @reviews = Review.where("body LIKE ?", "%#{content}%").page(params[:page]).per(50)
    elsif params[:tag].present?
      @members = []
      @reviews = Review.joins(:tags).where(tags: { name: params[:tag] }).page(params[:page]).per(50)
    else
      @members = []
      @reviews = []
    end
  end
end
