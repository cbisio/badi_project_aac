# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GeocodingService do
  let(:text) { 'Balmes,Barcelona' }
  let(:opts_empty) { {} }
  let(:search_results) { [{ "name": 'location1' }, { "name": 'location2' }] }

  context 'when third party API (TomTom) response code is 200' do
    it 'returns a Success object with the obtained data' do
      geocoding_service = GeocodingService.new(text, opts_empty)
      ok = double('Location Search results', code: 200, body: '{ "summary": {}, "results": [{ "name": "location1" }, {"name": "location2"}] }')
      expect(geocoding_service).to receive(:request_geocoding_third_api_service).and_return(ok)
      expect(geocoding_service).to receive(:clean_locations_response).and_return(search_results)
      expect(ObjectService::Success).to receive(:new).with(search_results)
      geocoding_service.call
    end
  end

  context 'when third party API (TomTom) response code is different than 200' do
    it 'returns an error object' do
      geocoding_service = GeocodingService.new(text, opts_empty)
      failure = double('Location Search results', code: 404)
      expect(geocoding_service).to receive(:request_geocoding_third_api_service).and_return(failure)
      expect(ObjectService::Error).to receive(:new).with(I18n.t('geocoding_service.errors.third_party_error'), 422)
      geocoding_service.call
    end
  end
end
