class Admin::ReviewCommentsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :admin_review_comment_handle_record_not_found
  def index
  end
end
