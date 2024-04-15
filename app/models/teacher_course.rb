class TeacherCourse < ApplicationRecord
  belongs_to :course
  belongs_to :teacher
  validates :course_id, uniqueness: { scope: :teacher_id, message: "combination already exists" }

end
