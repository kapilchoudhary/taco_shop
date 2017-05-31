class Taco < ApplicationRecord
  enum meat: [ :chicken, :steak ]

  # validations
  validates_presence_of :meat  
end
