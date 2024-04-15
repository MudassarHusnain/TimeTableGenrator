class Room < ApplicationRecord
  belongs_to :department
  has_many :dep_classes
end
