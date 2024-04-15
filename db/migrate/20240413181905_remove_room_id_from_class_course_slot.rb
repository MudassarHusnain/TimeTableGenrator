class RemoveRoomIdFromClassCourseSlot < ActiveRecord::Migration[7.0]
  def change
    remove_column :class_course_slots, :room_id, :integer
  end
end
