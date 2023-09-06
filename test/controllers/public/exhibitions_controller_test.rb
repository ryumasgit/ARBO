require "test_helper"

class Public::ExhibitionsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get public_exhibitions_index_url
    assert_response :success
  end

  test "should get show" do
    get public_exhibitions_show_url
    assert_response :success
  end

  test "should get reviews" do
    get public_exhibitions_reviews_url
    assert_response :success
  end
end
