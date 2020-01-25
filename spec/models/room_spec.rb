require 'rails_helper'

RSpec.describe Room, type: :model do
  
  it { should belong_to(:user) }

  it { should have_many(:photos) }

  it { should have_and_belong_to_many(:extras) }

  it 'validate presence of required fields ' do
    should validate_presence_of(:name)
    should validate_presence_of(:price)
    should validate_presence_of(:description)
    should validate_presence_of(:latitude)
    should validate_presence_of(:longitude)
    should validate_presence_of(:address)
  end
 
  it 'name length min max' do
    should validate_length_of(:name).is_at_least(5)
    should validate_length_of(:name).is_at_most(80)
  end
 
  it 'address length min max' do
    should validate_length_of(:address).is_at_least(10)
    should validate_length_of(:address).is_at_most(100)
  end

  it 'description length min max' do
    should validate_length_of(:description).is_at_least(10)
    should validate_length_of(:description).is_at_most(200)
  end

  it 'price number values: min max' do
    should validate_numericality_of(:price).is_greater_than(10)
    should validate_numericality_of(:price).is_less_than(1000)
  end
  
  it 'latitude number values: min max' do
    should validate_numericality_of(:latitude).is_greater_than(-90)
    should validate_numericality_of(:latitude).is_less_than(90)
  end

  it 'longitude number values: min max' do
    should validate_numericality_of(:longitude).is_greater_than(-180)
    should validate_numericality_of(:longitude).is_less_than(180)
  end
  

end