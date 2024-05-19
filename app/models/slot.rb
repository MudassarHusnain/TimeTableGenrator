class Slot < ApplicationRecord
  belongs_to :department
  has_many :class_course_slots, dependent: :destroy
  has_many :makeups, dependent: :destroy

  # Other validations or methods can be placed here
end
