class Room < ApplicationRecord
  belongs_to :department
  has_one :dep_classes
end
