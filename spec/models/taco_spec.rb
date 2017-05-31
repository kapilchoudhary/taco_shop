require 'rails_helper'

RSpec.describe Taco, type: :model do

  # ensure column meat is present before saving
  it { should validate_presence_of(:meat) }

  # ensure column meat is have only chicken or steak
  it { should define_enum_for(:meat).with([:chicken, :steak, :other_meat]) }

end
