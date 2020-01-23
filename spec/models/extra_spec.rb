require 'rails_helper'

RSpec.describe Extra, type: :model do
  it { should have_and_belong_to_many(:rooms) }

  it 'validate presence of required fields ' do
    should validate_presence_of(:name)
  end
end
