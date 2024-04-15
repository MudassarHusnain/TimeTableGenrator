class ClassCourseSlot < ApplicationRecord
  belongs_to :dep_class
  belongs_to :teacher_course
  belongs_to :slot
  
  validates :teacher_course_id, uniqueness: { scope: :dep_class_id, message: "combination already exists" }

end
