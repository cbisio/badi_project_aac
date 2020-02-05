# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ObjectService do
  describe 'Error class' do
    it 'initializes a new instance with its attributes' do
      expect(ObjectService::Error.new('Error message', 'Error code').error_message).to eq('Error message')
      expect(ObjectService::Error.new('Error message', 'Error code').error_code).to eq('Error code')
      expect(ObjectService::Error.new.error_message).to eq(nil)
      expect(ObjectService::Error.new.error_message).to eq(nil)
    end

    it 'returns false when success? method is called' do
      expect(ObjectService::Error.new.success?).to eq(false)
    end
  end

  describe 'Success class' do
    it 'initializes a new instance with its attributes' do
      expect(ObjectService::Success.new(data_set: {}).data).to eq(data_set: {})
    end

    it 'returns true when success? method is called' do
      expect(ObjectService::Success.new(data_set: {}).success?).to eq(true)
    end
  end
end
