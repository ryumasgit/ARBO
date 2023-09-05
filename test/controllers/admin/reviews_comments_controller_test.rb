require "test_helper"

class Admin::ReviewsCommentsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_reviews_comments_index_url
    assert_response :success
  end
end
