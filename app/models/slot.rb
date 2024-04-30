class Slot < ApplicationRecord
  belongs_to :department
  has_many :class_course_slots
  has_many :makeups
end
