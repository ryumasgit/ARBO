class Admin::ReviewCommentsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :admin_review_comment_handle_record_not_found

  def index
    @reviews = fetch_reviews(50)
    @review_comments = @review.review_comments.page(params[:page]).per(10)
  end

  def destroy
    review_comment = ReviewComment.find(params[:id])
    review_comment.destroy
    @review = Review.find(params[:review_id])
    @review_comments = @review.review_comments.page(params[:page]).per(10)
  end

  protected

  def fetch_reviews(page_size)
    reviews = Review.includes(:member, :review_comments, :exhibition)
                    .where(members: { is_active: true })
                    .order(created_at: :desc)
                    .page(params[:page]).per(page_size)
    reviews
  end
end
