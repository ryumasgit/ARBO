require "test_helper"

class Public::BadgesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get public_badges_index_url
    assert_response :success
  end
end
