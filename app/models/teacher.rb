class Teacher < ApplicationRecord
  belongs_to :department
  has_many :teacher_courses
  has_many :courses,through: :teacher_courses
end
