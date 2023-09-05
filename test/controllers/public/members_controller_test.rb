require "test_helper"

class Public::MembersControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get public_members_show_url
    assert_response :success
  end

  test "should get edit" do
    get public_members_edit_url
    assert_response :success
  end

  test "should get update" do
    get public_members_update_url
    assert_response :success
  end

  test "should get confirm_withdraw" do
    get public_members_confirm_withdraw_url
    assert_response :success
  end

  test "should get withdraw" do
    get public_members_withdraw_url
    assert_response :success
  end
end
