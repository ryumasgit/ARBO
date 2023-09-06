require "test_helper"

class Public::BookmarkExhibitionsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get public_bookmark_exhibitions_index_url
    assert_response :success
  end

  test "should get create" do
    get public_bookmark_exhibitions_create_url
    assert_response :success
  end

  test "should get destory" do
    get public_bookmark_exhibitions_destory_url
    assert_response :success
  end
end
