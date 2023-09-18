class Admin::ReviewCommentsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :admin_review_comment_handle_record_not_found

  def index
    @review = Review.find(params[:review_id])
    fetch_review_comments(10)
  end

  def destroy
    review_comment = ReviewComment.find(params[:id])
    review_comment.destroy
    @review = Review.find(params[:review_id])
    fetch_review_comments(10)
  end

  protected

  def fetch_review_comments(page_size)
    @review_comments = @review.review_comments
                      .includes(:member)
                      .where(members: { is_active: true })
                      .order(created_at: :desc)
                      .page(params[:page]).per(page_size)
  end
end
