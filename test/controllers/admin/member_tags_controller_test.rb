require "test_helper"

class Admin::MemberTagsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_member_tags_index_url
    assert_response :success
  end
end
