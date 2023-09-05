require "test_helper"

class Public::MuseumsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get public_museums_index_url
    assert_response :success
  end

  test "should get show" do
    get public_museums_show_url
    assert_response :success
  end
end
