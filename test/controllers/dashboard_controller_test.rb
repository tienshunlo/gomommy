require 'test_helper'

class DashboardControllerTest < ActionController::TestCase
  test "should get posts" do
    get :posts
    assert_response :success
  end

end
