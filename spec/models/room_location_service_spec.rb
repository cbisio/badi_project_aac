# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RoomLocationService, type: :model do
  it { should belong_to(:room) }

  it 'validate presence of required fields ' do
    should validate_presence_of(:health)
    should validate_presence_of(:leisure)
    should validate_presence_of(:transport)
    should validate_presence_of(:food)
    should validate_presence_of(:tourism)
  end

  it 'health number values min:' do
    should validate_numericality_of(:health).is_greater_than_or_equal_to(0)
  end

  it 'leisure number values min:' do
    should validate_numericality_of(:leisure).is_greater_than_or_equal_to(0)
  end

  it 'transport number values min:' do
    should validate_numericality_of(:transport).is_greater_than_or_equal_to(0)
  end

  it 'food number values min:' do
    should validate_numericality_of(:food).is_greater_than_or_equal_to(0)
  end

  it 'tourism number values min:' do
    should validate_numericality_of(:tourism).is_greater_than_or_equal_to(0)
  end
end
