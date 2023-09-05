require "test_helper"

class Admin::MuseumsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get admin_museums_new_url
    assert_response :success
  end

  test "should get create" do
    get admin_museums_create_url
    assert_response :success
  end

  test "should get index" do
    get admin_museums_index_url
    assert_response :success
  end

  test "should get show" do
    get admin_museums_show_url
    assert_response :success
  end

  test "should get edit" do
    get admin_museums_edit_url
    assert_response :success
  end

  test "should get update" do
    get admin_museums_update_url
    assert_response :success
  end

  test "should get destroy" do
    get admin_museums_destroy_url
    assert_response :success
  end
end
