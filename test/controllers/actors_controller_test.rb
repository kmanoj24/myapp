require "test_helper"

class ActorsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get actors_index_url
    assert_response :success
  end

  test "should get show" do
    get actors_show_url
    assert_response :success
  end

  test "should get create" do
    get actors_create_url
    assert_response :success
  end

  test "should get update" do
    get actors_update_url
    assert_response :success
  end

  test "should get destroy" do
    get actors_destroy_url
    assert_response :success
  end
end
