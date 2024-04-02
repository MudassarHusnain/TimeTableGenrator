require "application_system_test_case"

class DepClassesTest < ApplicationSystemTestCase
  setup do
    @dep_class = dep_classes(:one)
  end

  test "visiting the index" do
    visit dep_classes_url
    assert_selector "h1", text: "Dep classes"
  end

  test "should create dep class" do
    visit dep_classes_url
    click_on "New dep class"

    fill_in "Department", with: @dep_class.department_id
    fill_in "Name", with: @dep_class.name
    fill_in "Room", with: @dep_class.room_id
    fill_in "Strength", with: @dep_class.strength
    click_on "Create Dep class"

    assert_text "Dep class was successfully created"
    click_on "Back"
  end

  test "should update Dep class" do
    visit dep_class_url(@dep_class)
    click_on "Edit this dep class", match: :first

    fill_in "Department", with: @dep_class.department_id
    fill_in "Name", with: @dep_class.name
    fill_in "Room", with: @dep_class.room_id
    fill_in "Strength", with: @dep_class.strength
    click_on "Update Dep class"

    assert_text "Dep class was successfully updated"
    click_on "Back"
  end

  test "should destroy Dep class" do
    visit dep_class_url(@dep_class)
    click_on "Destroy this dep class", match: :first

    assert_text "Dep class was successfully destroyed"
  end
end
