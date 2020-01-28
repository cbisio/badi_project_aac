require 'rails_helper'

RSpec.describe Photo, type: :model do
  it { should belong_to(:room) }

  it 'validate presence of required fields ' do
    should validate_presence_of(:url)
    should validate_presence_of(:order)
  end

  it 'order number values: min' do
    should validate_numericality_of(:order).is_greater_than(0)
  end

  it 'url length min max' do
    should validate_length_of(:url).is_at_least(5)
    should validate_length_of(:url).is_at_most(120)
  end
end
