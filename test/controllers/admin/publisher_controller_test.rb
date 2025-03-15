require "test_helper"

class Admin::PublisherControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_publisher_index_url
    assert_response :success
  end

  test "should get show" do
    get admin_publisher_show_url
    assert_response :success
  end

  test "should get edit" do
    get admin_publisher_edit_url
    assert_response :success
  end

  test "should get update" do
    get admin_publisher_update_url
    assert_response :success
  end

  test "should get destroy" do
    get admin_publisher_destroy_url
    assert_response :success
  end
end
