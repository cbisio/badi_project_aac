require 'rails_helper'

RSpec.describe City, type: :model do
  
  it { should have_many(:rooms) }

  it 'name length min max' do
    should validate_length_of(:name).is_at_least(3)
    should validate_length_of(:name).is_at_most(80)
  end

  it 'uniqueness' do
    should validate_uniqueness_of(:name)
  end
end
