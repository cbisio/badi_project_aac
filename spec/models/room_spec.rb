require 'rails_helper'

RSpec.describe Room, type: :model do
  
  it { should belong_to(:user) }

  it { should belong_to(:city) }

  it { should have_many(:photos) }

  it { should have_and_belong_to_many(:extras) }

  it 'validate presence of required fields ' do
    should validate_presence_of(:name)
    should validate_presence_of(:price)
    should validate_presence_of(:latitude)
    should validate_presence_of(:longitude)
    should validate_presence_of(:address)
    should validate_presence_of(:currency)
  end
 
  it 'currency must be € or $' do
    room = Room.new
    expect(room).to validate_inclusion_of(:currency).in_array(%w[€ $]).with_message(I18n.t('currency'))
  end

  it 'name length min max' do
    should validate_length_of(:name).is_at_least(5).with_message(I18n.t('name.short', minchar: 5))
    should validate_length_of(:name).is_at_most(80).with_message(I18n.t('name.long', maxchar: 80))
  end
 
  it 'address length min max' do
    should validate_length_of(:address).is_at_least(10).with_message(I18n.t('address.short', minchar: 10))
    should validate_length_of(:address).is_at_most(200).with_message(I18n.t('address.long', maxchar: 200))
  end

  it 'price number values: min max' do
    should validate_numericality_of(:price).is_greater_than(10).with_message(I18n.t('price'))
    should validate_numericality_of(:price).is_less_than(10000).with_message(I18n.t('price'))
  end

  it 'latitude number values: min max' do
    should validate_numericality_of(:latitude).is_greater_than(-90).with_message(I18n.t('latitude'))
    should validate_numericality_of(:latitude).is_less_than(90).with_message(I18n.t('latitude'))
  end

  it 'longitude number values: min max' do
    should validate_numericality_of(:longitude).is_greater_than(-180).with_message(I18n.t('longitude'))
    should validate_numericality_of(:longitude).is_less_than(180).with_message(I18n.t('longitude'))
  end
end
