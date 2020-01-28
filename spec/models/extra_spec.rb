require 'rails_helper'

RSpec.describe Extra, type: :model do
  it { should have_and_belong_to_many(:rooms) }

  it 'validate presence of required fields ' do
    should validate_presence_of(:name)
  end

  it 'name length min max' do
    should validate_length_of(:name).is_at_least(2)
    should validate_length_of(:name).is_at_most(160)
  end

  it 'uniqueness' do
    should validate_uniqueness_of(:name)
  end

end
