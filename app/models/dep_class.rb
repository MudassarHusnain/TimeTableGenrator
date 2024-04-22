class DepClass < ApplicationRecord
  belongs_to :room
  belongs_to :department
  has_many :class_course_slots , :dependent => :destroy
  has_many :slots , :through => :class_course_slots
  validates :name, presence: true
  validates :class_type, presence: true
  enum class_type: {morning: "morning",afternoon: "afternoon"}

end
