require 'test_helper'

class CheckOutControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get check_out_index_url
    assert_response :success
  end

end
