require 'rails_helper'

RSpec.describe 'Room Api request', type: :request do

  describe 'GET /V1/room/:id' do
    # Arrange test data
    let!(:city) { create(:city) }
    let!(:user) { create(:user) }
    let!(:room) { create(:room, city_id: city.id,  user_id: user.id) }

    context 'when room exist' do
      before { get "/V1/room/#{room.id}" }

      it 'return statuscode = 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns room with same id' do
        payload = JSON.parse(response.body)
        expect(payload["id"]).to eq(room.id)
      end

      it 'returnsnum_visits + 1' do
        payload = JSON.parse(response.body)
        expect(RoomView.one?).to eq(true)
        expect(payload["num_visits"]).to eq(room.num_visits + 1)
      end
    end

    context 'when room does not exist' do
      before { get "/V1/room/123456789" }

      it 'return statuscode = 404' do 
        expect(response).to have_http_status(404)
      end
    end
  end

  describe 'GET /V1/rooms' do

    let(:top_left_lat) { 41.5 }
    let(:btm_right_lat) { 41.3 }
    let(:top_left_lon) { 2.0 }
    let(:btm_right_lon) { 2.3 }
    let(:city_name) { "Barcelona" }
    let(:page) { 1 }
    let(:size) { 5 }

    context "With results and pagination" do 
      before do
        ok = double("Search Rooms Results", "success?" => true, data: { rooms: Array.new(size) })
        expect(SearchRoomsService).to receive(:call).with(
          {
            top_left_lat: top_left_lat.to_s,
            top_left_lon: top_left_lon.to_s
          },
          {
            bottom_right_lat: btm_right_lat.to_s,
            bottom_right_lon: btm_right_lon.to_s
          },
          {
            city: city_name,
            page: page.to_s,
            size: size.to_s
          }
        ).and_return(ok)
        get "/V1/rooms?city=#{city_name}&topleft_lat=#{top_left_lat}&btmright_lat=#{btm_right_lat}&topleft_lon=#{top_left_lon}&btmright_lon=#{btm_right_lon}&page=#{page}&size=#{size}"
      end

      it 'returns statuscode = 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns not empty' do
        payload = JSON.parse(response.body)
        expect(payload).not_to be_empty
      end

      it 'returns a rooms array with the specified size' do
        payload = JSON.parse(response.body)
        expect(payload['rooms'].size).to eq(size)
      end
    end

    context "without results and without pagination" do
      before do
        failed = double("Search Rooms Results", "success?" => false, error_code: 404, error_message: "Not rooms found")

        expect(SearchRoomsService).to receive(:call).with(
          {
            top_left_lat: top_left_lat.to_s,
            top_left_lon: top_left_lon.to_s,
          },
          {
            bottom_right_lat: btm_right_lat.to_s,
            bottom_right_lon: btm_right_lon.to_s
          },
          {
            city: city_name
          }
        ).and_return(failed)
        get "/V1/rooms?city=#{city_name}&topleft_lat=#{top_left_lat}&btmright_lat=#{btm_right_lat}&topleft_lon=#{top_left_lon}&btmright_lon=#{btm_right_lon}"
      end

      it 'returns statuscode = 404' do
        expect(response).to have_http_status(404)
      end
    end
  end
end
