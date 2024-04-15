class Department < ApplicationRecord
  has_many :courses
  has_many :teachers
  has_many :rooms
  has_many :dep_classes
  has_many :slots
end
