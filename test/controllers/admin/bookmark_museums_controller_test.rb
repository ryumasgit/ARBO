require "test_helper"

class Admin::BookmarkMuseumsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_bookmark_museums_index_url
    assert_response :success
  end
end
