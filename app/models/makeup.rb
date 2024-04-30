class Makeup < ApplicationRecord

  belongs_to :dep_class
  belongs_to :teacher_course
  belongs_to :slot

  validates :teacher_course_id, uniqueness: { scope: :dep_class_id, message: "combination already exists" }
  validates :teacher_course_id, presence: true

  enum days: { day1: 1, day2: 2,day3: 3 }

  def self.get_the_teacher_used_slots(teacher,day)
    reserved_slots = self.joins(:teacher_course)
                         .where(teacher_courses: { teacher_id: teacher.id })
                         .where(days: day)
                         .pluck(:slot_id)
    return reserved_slots
  end

  def self.get_class_course_slots(dep_c,day)
    reserved_slots = dep_c.makeups.where(days: day).pluck(:slot_id)
    return reserved_slots
  end
end
