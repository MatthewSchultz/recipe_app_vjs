require 'test_helper'

class RootTest < ActionDispatch::IntegrationTest
  test 'get site root' do
    get '/'
    assert_response :success
    assert_select 'link[rel=stylesheet][href=?]', 'https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css'
  end
end
