class Public::SearchesController < ApplicationController
  before_action :authenticate_member!

  def index
    if params[:content].present?
      content = params[:content]
      @members = Member.where("name LIKE ?", "%#{content}%").page(params[:page]).per(5)
      @reviews = Review.where("body LIKE ?", "%#{content}%").page(params[:page]).per(5)
      # elsif @model == "Tag"
      #   @records = Tag.search_books_for(@content, @method)
    end
  end
end
