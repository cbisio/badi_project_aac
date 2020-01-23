require 'rails_helper'

RSpec.describe User, type: :model do

  it { should have_many(:rooms) }

  it 'validate presence of require fields ' do
    should validate_presence_of(:name)
    should validate_presence_of(:birth)
    should validate_presence_of(:gender)
  end

end
