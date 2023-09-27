class Public::SearchesController < ApplicationController
  before_action :authenticate_member!

  def index
    if params[:content].present?
      content = params[:content]
      @members = Member.where("name LIKE ? AND is_active = ?", "%#{content}%", true).page(params[:page])
      @reviews = Review.joins(:member).where(members: { is_active: true }).where("body LIKE ?", "%#{content}%").page(params[:page])
    elsif params[:tag].present?
      @members = []
      @reviews = Review.joins(:tags)
               .joins(:member)
               .where(tags: { name: params[:tag] })
               .where(members: { is_active: true })
               .page(params[:page])
    else
      @members = []
      @reviews = []
    end
  end
end
