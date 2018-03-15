require 'test_helper'

class ChatworkApisControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get chatwork_apis_index_url
    assert_response :success
  end

  test "should get new" do
    get chatwork_apis_new_url
    assert_response :success
  end

  test "should get create" do
    get chatwork_apis_create_url
    assert_response :success
  end

end
