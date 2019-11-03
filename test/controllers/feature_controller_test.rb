require 'test_helper'

class FeatureControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get feature_index_url
    assert_response :success
  end

  test "should get show" do
    get feature_show_url
    assert_response :success
  end

end
