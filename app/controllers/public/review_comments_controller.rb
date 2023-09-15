class Public::ReviewCommentsController < ApplicationController
  before_action :authenticate_member!
  before_action :member_is_guest?, only: [:create, :destroy]
  rescue_from ActiveRecord::RecordNotFound, with: :public_review_comment_handle_record_not_found

  def index
    @review = Review.find(params[:review_id])
    @review_comments = @review.review_comments
    @review_comment = ReviewComment.new
  end

  def create
    # @review_comment = ReviewComment.new(review_comment_params)
    # @review = ReviewComment.find(params[:review_id])
    # review_comment = current_member.review_comments.new(review_comment_params)
    # review_comment.review_id = @review.id
    # review_comment.save
  end

  def destroy
  #   review_comment = ReviewComment.find(params[:id])
  #   review_comment.destroy
  #   @book = Book.find(params[:book_id])
  end

  private

  def review_comment_params
    params.require(:review_comment).permit(:comment)
  end
end
