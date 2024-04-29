class CreateMakeups < ActiveRecord::Migration[7.0]
  def change
    create_table :makeups do |t|
      t.integer :dep_class_id
      t.integer :slot
      t.integer :teacher_course_id
      t.integer :days

      t.timestamps
    end
  end
end
