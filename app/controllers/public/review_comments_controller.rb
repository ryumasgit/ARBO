class Public::ReviewCommentsController < ApplicationController
  before_action :authenticate_member!
  before_action :member_is_guest?, only: [:create, :destroy]
  rescue_from ActiveRecord::RecordNotFound, with: :public_review_comment_handle_record_not_found

  def index
    @review = Review.find(params[:review_id])
    @review_comments = @review.review_comments.page(params[:page]).per(10)
    @review_comment = ReviewComment.new
  end

  def create
    review = Review.find(params[:review_id])
    review_comment = current_member.review_comments.new(review_comment_params)
    review_comment.review_id = review.id
    review_comment.save
    redirect_to review_review_comments_path(review)
  end

  def destroy
    review = Review.find(params[:review_id])
    review_comment = ReviewComment.find(params[:id])
    review_comment.destroy
    redirect_to review_review_comments_path(review)
  end

  private

  def review_comment_params
    params.require(:review_comment).permit(:comment)
  end
end
