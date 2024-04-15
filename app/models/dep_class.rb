class DepClass < ApplicationRecord
  belongs_to :room
  belongs_to :department
  has_many :class_course_slots
end
