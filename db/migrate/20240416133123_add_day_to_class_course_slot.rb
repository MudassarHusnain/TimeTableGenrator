class AddDayToClassCourseSlot < ActiveRecord::Migration[7.0]
  def change
    add_column :class_course_slots, :days, :integer
  end
end
