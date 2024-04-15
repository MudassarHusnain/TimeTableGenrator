require "test_helper"

class ClassCourseSlotsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @class_course_slot = class_course_slots(:one)
  end

  test "should get index" do
    get class_course_slots_url
    assert_response :success
  end

  test "should get new" do
    get new_class_course_slot_url
    assert_response :success
  end

  test "should create class_course_slot" do
    assert_difference("ClassCourseSlot.count") do
      post class_course_slots_url, params: { class_course_slot: { dep_class_id: @class_course_slot.dep_class_id, room_id: @class_course_slot.room_id, slot_id: @class_course_slot.slot_id, teacher_course_id: @class_course_slot.teacher_course_id } }
    end

    assert_redirected_to class_course_slot_url(ClassCourseSlot.last)
  end

  test "should show class_course_slot" do
    get class_course_slot_url(@class_course_slot)
    assert_response :success
  end

  test "should get edit" do
    get edit_class_course_slot_url(@class_course_slot)
    assert_response :success
  end

  test "should update class_course_slot" do
    patch class_course_slot_url(@class_course_slot), params: { class_course_slot: { dep_class_id: @class_course_slot.dep_class_id, room_id: @class_course_slot.room_id, slot_id: @class_course_slot.slot_id, teacher_course_id: @class_course_slot.teacher_course_id } }
    assert_redirected_to class_course_slot_url(@class_course_slot)
  end

  test "should destroy class_course_slot" do
    assert_difference("ClassCourseSlot.count", -1) do
      delete class_course_slot_url(@class_course_slot)
    end

    assert_redirected_to class_course_slots_url
  end
end
