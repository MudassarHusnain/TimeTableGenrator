require "application_system_test_case"

class ClassCourseSlotsTest < ApplicationSystemTestCase
  setup do
    @class_course_slot = class_course_slots(:one)
  end

  test "visiting the index" do
    visit class_course_slots_url
    assert_selector "h1", text: "Class course slots"
  end

  test "should create class course slot" do
    visit class_course_slots_url
    click_on "New class course slot"

    fill_in "Dep class", with: @class_course_slot.dep_class_id
    fill_in "Room", with: @class_course_slot.room_id
    fill_in "Slot", with: @class_course_slot.slot_id
    fill_in "Teacher course", with: @class_course_slot.teacher_course_id
    click_on "Create Class course slot"

    assert_text "Class course slot was successfully created"
    click_on "Back"
  end

  test "should update Class course slot" do
    visit class_course_slot_url(@class_course_slot)
    click_on "Edit this class course slot", match: :first

    fill_in "Dep class", with: @class_course_slot.dep_class_id
    fill_in "Room", with: @class_course_slot.room_id
    fill_in "Slot", with: @class_course_slot.slot_id
    fill_in "Teacher course", with: @class_course_slot.teacher_course_id
    click_on "Update Class course slot"

    assert_text "Class course slot was successfully updated"
    click_on "Back"
  end

  test "should destroy Class course slot" do
    visit class_course_slot_url(@class_course_slot)
    click_on "Destroy this class course slot", match: :first

    assert_text "Class course slot was successfully destroyed"
  end
end
