require 'rails_helper'

RSpec.describe User, type: :model do

  it { should have_many(:rooms) }

  it 'validate presence of require fields ' do
    should validate_presence_of(:name)
    should validate_presence_of(:birth_date).with_message(I18n.t('birth_date'))
    should validate_presence_of(:gender)
  end

  it 'gender must be Male, Female or Other' do
    user = User.new
    expect(user).to validate_inclusion_of(:gender).in_array(%w[Male Female Other]).with_message(I18n.t('gender'))
  end

  it 'name length min max' do
    should validate_length_of(:name).is_at_least(3).with_message(I18n.t('name.short', minchar: 3))
    should validate_length_of(:name).is_at_most(80).with_message(I18n.t('name.long', maxchar: 80))
  end

end
