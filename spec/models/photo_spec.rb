require 'rails_helper'

RSpec.describe Photo, type: :model do
  it { should belong_to(:room) }

  it 'validate presence of required fields ' do
    should validate_presence_of(:url)
    should validate_presence_of(:order)
  end
end
