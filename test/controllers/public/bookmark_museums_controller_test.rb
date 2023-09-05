require "test_helper"

class Public::BookmarkMuseumsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get public_bookmark_museums_index_url
    assert_response :success
  end

  test "should get create" do
    get public_bookmark_museums_create_url
    assert_response :success
  end

  test "should get destroy" do
    get public_bookmark_museums_destroy_url
    assert_response :success
  end
end
