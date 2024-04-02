require "test_helper"

class DepClassesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @dep_class = dep_classes(:one)
  end

  test "should get index" do
    get dep_classes_url
    assert_response :success
  end

  test "should get new" do
    get new_dep_class_url
    assert_response :success
  end

  test "should create dep_class" do
    assert_difference("DepClass.count") do
      post dep_classes_url, params: { dep_class: { department_id: @dep_class.department_id, name: @dep_class.name, room_id: @dep_class.room_id, strength: @dep_class.strength } }
    end

    assert_redirected_to dep_class_url(DepClass.last)
  end

  test "should show dep_class" do
    get dep_class_url(@dep_class)
    assert_response :success
  end

  test "should get edit" do
    get edit_dep_class_url(@dep_class)
    assert_response :success
  end

  test "should update dep_class" do
    patch dep_class_url(@dep_class), params: { dep_class: { department_id: @dep_class.department_id, name: @dep_class.name, room_id: @dep_class.room_id, strength: @dep_class.strength } }
    assert_redirected_to dep_class_url(@dep_class)
  end

  test "should destroy dep_class" do
    assert_difference("DepClass.count", -1) do
      delete dep_class_url(@dep_class)
    end

    assert_redirected_to dep_classes_url
  end
end
