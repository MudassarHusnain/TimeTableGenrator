class Teacher < ApplicationRecord
  belongs_to :department
  has_many :teacher_courses, dependent: :destroy
  has_many :courses, through: :teacher_courses, dependent: :destroy
  has_many :makeups, through: :teacher_courses, dependent: :destroy
  has_many :class_course_slots, through: :teacher_courses, dependent: :destroy

  # Other validations or methods can be placed here
end
