require 'rails_helper'

RSpec.describe 'Room Api request', type: :request do
  ## Arrange test data
  let!(:city) { create(:city) }
  let!(:user) { create(:user) }
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

      it 'returns num_visits + 1' do
        payload = JSON.parse(response.body)
        expect(RoomView.one?).to eq(true)
        expect(payload["num_visits"]).to eq(1)
      end
    end

    context 'when room does not exist' do
      before { get "/V1/room/123456789" }

      it 'return statuscode = 404' do 
        expect(response).to have_http_status(404)
      end
    end
  end

  describe 'GET /V1/rooms?city=Barcelona&topleft_lat=1.0&btmright_lat=0.0&topleft_long=151&btmright_long=100.0' do

    context 'when there are rooms ' do
      before { get "/V1/rooms?city=#{city.name}&topleft_lat=#{room.latitude-1}&btmright_lat=#{room.latitude+1}&topleft_long=#{room.longitude-1}&btmright_long=#{room.longitude+1}"}

      it 'return statuscode = 200' do 
        expect(response).to have_http_status(200)
      end

      it 'return not empty' do 
        payload = JSON.parse(response.body)
        expect(payload).not_to be_empty
      end
    end

    context 'when there are no rooms' do
      before { get "/V1/rooms?city=NoExists&topleft_lat=0&btmright_lat=0&topleft_long=0&btmright_long=0"}

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
