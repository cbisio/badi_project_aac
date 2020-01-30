require 'rails_helper'

RSpec.describe IpRoom, type: :model do
  it { should belong_to(:room) }

  it 'validate presence of required fields ' do
    should validate_presence_of(:ip)
  end

  it 'ip length min max' do
    should validate_length_of(:ip).is_at_least(7)
    should validate_length_of(:ip).is_at_most(15)
  end

end
