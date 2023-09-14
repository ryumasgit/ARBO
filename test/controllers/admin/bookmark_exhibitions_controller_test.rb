require "test_helper"

class Admin::BookmarkExhibitionsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_bookmark_exhibitions_index_url
    assert_response :success
  end
end
