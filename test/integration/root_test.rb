require 'test_helper'

class RootTest < ActionDispatch::IntegrationTest
  test "get site root" do
    get '/'
    assert_response :success
  end
end
