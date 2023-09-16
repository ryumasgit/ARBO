module Public::ReviewCommentsHelper

  def can_comments_be_deleted?(review_comment)
    review_comment.member == current_member || review_comment.review.member == current_member
  end
end