class Room < ApplicationRecord
  belongs_to :department
  has_many :dep_classes, dependent: :destroy

  # Other validations or methods can be placed here
end
