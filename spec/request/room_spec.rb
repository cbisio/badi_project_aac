require 'rails_helper'

RSpec.describe 'Room Api request', type: :request do
  ## Arrange test data 
  let!(:city){create(:city)}
  let!(:user){create(:user)}
  let!(:room) { create(:room, city_id: city.id,  user_id: user.id) }

  describe 'GET /V1/room/:id' do
    context 'when room exist' do
      before { get "/V1/room/#{room.id}" }

      it 'return statuscode = 200' do 
        expect(response).to have_http_status(200)
      end

      it 'returns room with same id' do
        payload = JSON.parse(response.body) 
        expect(payload["id"]).to eq(room.id)
      end
    end

    context 'when room does not exist' do
      before { get "/V1/room/123456789" }

      it 'return statuscode = 404' do 
        expect(response).to have_http_status(404)
      end
    end
  end

  describe 'GET /V1/roomsBounds?city=Barcelona&x0=1.0&y0=0.0&x1=151&y1=100.0' do

    context 'when there are rooms ' do
      before { get "/V1/roomsBounds?city=#{city.name}&y0=#{room.latitude-1}&y1=#{room.latitude+1}&x0=#{room.longitude-1}&x1=#{room.longitude+1}"}

      it 'return statuscode = 200' do 
        expect(response).to have_http_status(200)
      end

      it 'return not empty' do 
        payload = JSON.parse(response.body) 
        expect(payload).not_to be_empty
      end
    end

    context 'when there are no rooms' do
      before { get "/V1/roomsBounds?city=NoExists&y0=0&y1=0&x0=0&x1=0"}
      
      it 'return statuscode = 404' do
        expect(response).to have_http_status(404)
      end

      it 'return empty response' do 
        payload = JSON.parse(response.body) 
        expect(payload["error"]).not_to be_empty
      end
    end
  end
end
