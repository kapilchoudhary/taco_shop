class Taco < ApplicationRecord
  enum meat: [ :chicken, :steak, :other_meat ]

  # validations
  validates_presence_of :meat  
end
