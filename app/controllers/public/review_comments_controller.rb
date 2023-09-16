class Public::ReviewCommentsController < ApplicationController
  before_action :authenticate_member!
  before_action :member_is_guest?, only: [:create, :destroy]
  before_action :get_review_id
  rescue_from ActiveRecord::RecordNotFound, with: :public_review_comment_handle_record_not_found

  def index
    @review_comments = @review.review_comments
                .includes(:member)
                .where(members: { is_active: true })
                .page(params[:page]).per(10)
    @review_comment = ReviewComment.new
  end

  def create
    review_comment = current_member.review_comments.new(review_comment_params)
    review_comment.review_id = @review.id
    review_comment.save
    @review_comments = @review.review_comments.page(params[:page]).per(10)
  end

  def destroy
    review_comment = ReviewComment.find(params[:id])
    review_comment.destroy
    @review_comments = @review.review_comments.page(params[:page]).per(10)
  end

  private

  def review_comment_params
    params.require(:review_comment).permit(:comment)
  end

  def get_review_id
    @review = Review.find(params[:review_id])
  end
end
