class CreateClassCourseSlots < ActiveRecord::Migration[7.0]
  def change
    create_table :class_course_slots do |t|
      t.references :dep_class, null: false, foreign_key: true
      t.references :teacher_course, null: false, foreign_key: true
      t.references :slot,foreign_key: true
      t.references :room,foreign_key: true

      t.timestamps
    end
  end
end
