require 'rails_helper'

RSpec.describe 'Search', type: :request do
  describe 'GET /search' do
    context 'when search_text query param exists' do
      before { get '/V1/search?text=Balmes&nbsp;Barcelona' }

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
    end

    context 'when search_text query param does not exist' do
      it 'returns a 422 status code' do
        get '/V1/search'
        expect(response).to have_http_status(422)
      end
    end
  end
end
