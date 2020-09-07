require 'test_helper'

class Staff::HomeControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get staff_home_index_url
    assert_response :success
  end

end
