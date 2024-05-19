class Department < ApplicationRecord
  has_many :courses, dependent: :destroy
  has_many :teachers, dependent: :destroy
  has_many :rooms, dependent: :destroy
  has_many :dep_classes, dependent: :destroy
  has_many :slots, dependent: :destroy

  validates :name, presence: true
end
