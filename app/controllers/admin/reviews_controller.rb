class Admin::ReviewsController < ApplicationController
  before_action :get_review_id, except: [:index]
  rescue_from ActiveRecord::RecordNotFound, with: :admin_review_handle_record_not_found

  def show
    @review_comments = @review.review_comments
                      .includes(:member)
                      .where(members: { is_active: true })
                      .order(created_at: :desc)
                      .page(params[:page])
  end

  def index
    @reviews = Review.includes(:member, :review_comments, :exhibition, :museums)
                      .where(members: { is_active: true })
                      .where(exhibitions: { is_active: true })
                      .where(museums: { is_active: true })
                      .order(created_at: :desc)
                      .page(params[:page])
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