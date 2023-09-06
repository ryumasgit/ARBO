require "test_helper"

class Admin::RelationshipsControllerTest < ActionDispatch::IntegrationTest
  test "should get follows" do
    get admin_relationships_follows_url
    assert_response :success
  end

  test "should get followers" do
    get admin_relationships_followers_url
    assert_response :success
  end
end
