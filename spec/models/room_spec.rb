require 'rails_helper'

RSpec.describe Room, type: :model do
  
  it { should belong_to(:user) }

  it 'validate presence of required fields ' do
    should validate_presence_of(:name)
    should validate_presence_of(:price)
    should validate_presence_of(:description)
    should validate_presence_of(:latitude)
    should validate_presence_of(:longitude)
  end
  
end
