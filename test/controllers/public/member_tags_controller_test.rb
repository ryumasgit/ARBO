require "test_helper"

class Public::MemberTagsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get public_member_tags_index_url
    assert_response :success
  end

  test "should get create" do
    get public_member_tags_create_url
    assert_response :success
  end

  test "should get destroy" do
    get public_member_tags_destroy_url
    assert_response :success
  end
end
