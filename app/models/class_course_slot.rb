class ClassCourseSlot < ApplicationRecord
  belongs_to :dep_class
  belongs_to :teacher_course
  belongs_to :slot
end
