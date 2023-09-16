class Admin::ReviewCommentsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :admin_review_comment_handle_record_not_found
    
  def index
    @review = Review.find(params[:review_id])
    @review_comments = @review.review_comments.page(params[:page]).per(10)
  end
  
  def destroy
    review_comment = ReviewComment.find(params[:id])
    review_comment.destroy
    @review = Review.find(params[:review_id])
    @review_comments = @review.review_comments.page(params[:page]).per(10)
  end
end
