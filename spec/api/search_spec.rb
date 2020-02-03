require 'rails_helper'

RSpec.describe 'Search', type: :request do
  describe 'GET /search' do
    let(:text) { "Balmes,Barcelona"}
    let(:limit) { 3 }

    context 'when search_text query param exists' do
      before do
        ok = double("Search locations Results", "success?" => true, data: { locations: [] })
        expect(GeocodingService).to receive(:call).with(text, {}).and_return(ok)
        get "/V1/search?text=#{text}"
      end

      it 'returns a 200 status code' do
        expect(response).to have_http_status(200)
      end

      it 'returns data' do
        payload = JSON.parse(response.body)
        expect(payload).not_to be_empty
      end

      it 'does not return 424 status code' do
        expect(response).not_to have_http_status(424)
      end

      context 'when limit param exists' do
        before do
          ok = double("Search locations Results", "success?" => true, data: { locations: Array.new(limit) })
          expect(GeocodingService).to receive(:call).with(
            text,
            limit: limit
          ).and_return(ok)
          get "/V1/search?text=#{text}&limit=#{limit}"
        end

        it 'returns a list of locations with the specified limit size' do
          payload = JSON.parse(response.body)
          expect(payload['locations'].size).to eq(limit)
        end
      end
    end

    context 'when search_text query param does not exist' do
      it 'returns a 422 status code' do
        get '/V1/search'
        expect(response).to have_http_status(422)
      end
    end

    context 'when Geocoding service returns an error object' do
      it 'returns a response with the Geocoding Service error code' do
        failure = double(
          'Search locations Results',
          'success?' => false,
          'error_code' => 422,
          'error_message' => 'Geocoding service failed'
        )
        expect(GeocodingService).to receive(:call).and_return(failure)
        get "/V1/search?text=#{text}&limit=#{limit}"
        expect(response).to have_http_status(failure.error_code)
      end
    end
  end
end
