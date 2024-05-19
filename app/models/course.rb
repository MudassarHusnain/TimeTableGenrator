class Course < ApplicationRecord
  belongs_to :department
  has_many :teacher_courses, dependent: :destroy
  has_many :teachers, through: :teacher_courses, dependent: :destroy
  has_many :class_course_slots,through: :teacher_courses,dependent: :destroy
  has_many :makeups, dependent: :destroy
  
  attr_accessor :teacher_id
end
