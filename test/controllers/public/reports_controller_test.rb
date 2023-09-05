require "test_helper"

class Public::ReportsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get public_reports_show_url
    assert_response :success
  end
end
