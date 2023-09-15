class Admin::ReviewsController < ApplicationController
  before_action :get_review_id, except: [:index]

  def show
  end

  def index
    @reviews = Review.includes(:member)
                .order(created_at: :desc)
                .page(params[:page])
                .per(50)
  end

  def destroy
    if @review.destroy
      set_flash_message("レビューの削除に成功しました")
      redirect_to admin_reviews_path
    else
      set_flash_message("レビューの削除に失敗しました")
      render :show
    end
  end

  protected

  def get_review_id
    @review = Review.find(params[:id])
  end
end