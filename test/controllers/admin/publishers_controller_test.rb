require "test_helper"

class Admin::PublishersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_publishers_index_url
    assert_response :success
  end

  test "should get show" do
    get admin_publishers_show_url
    assert_response :success
  end

  test "should get edit" do
    get admin_publishers_edit_url
    assert_response :success
  end

  test "should get update" do
    get admin_publishers_update_url
    assert_response :success
  end

  test "should get destroy" do
    get admin_publishers_destroy_url
    assert_response :success
  end
end
