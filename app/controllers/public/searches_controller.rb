class Public::SearchesController < ApplicationController
  before_action :authenticate_member!

  def index
    if params[:content].present?
      content = params[:content]
      @members = Member.where("name LIKE ?", "%#{content}%").page(params[:page])
      @reviews = Review.where("body LIKE ?", "%#{content}%").page(params[:page])
    elsif params[:tag].present?
      @members = []
      @reviews = Review.joins(:tags).where(tags: { name: params[:tag] }).page(params[:page])
    else
      @members = []
      @reviews = []
    end
  end
end
