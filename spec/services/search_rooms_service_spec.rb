require 'rails_helper'

RSpec.describe SearchRoomsService do
  context 'when there is pagination' do
    let(:search_room_service) { SearchRoomsService.new(
    {
      top_left_lat: 41.5,
      top_left_lon: 2.0
    },
    {
      bottom_right_lat: 41.3,
      bottom_right_lon: 2.3
    },
    {
      city: "Barcelona",
      page: 10,
      size: 2
    })}

    it 'searches rooms with correct query' do
      results = double("Elastic Search results", results: ["Room1", "Room 2"])
      expect(Room).to receive(:search).with(query:
      {
        bool: {
          must: [
          {
            geo_bounding_box: {
              location: {
                top_left: {
                  lat: 41.5,
                  lon: 2.0
                },
                bottom_right: {
                  lat: 41.3,
                  lon: 2.3
                }
              }
            }
          },
          { match: { 'city.name': "Barcelona" }}
          ]
        }
      },
      from: 10,
      size: 2).and_return(results)

      expect(ObjectService::Success).to receive(:new)

      search_room_service.call
    end
  end

  context 'when there is no pagination' do
    let(:search_room_service) { SearchRoomsService.new(
    {
      top_left_lat: 41.5,
      top_left_lon: 2.0
    },
    {
      bottom_right_lat: 41.3,
      bottom_right_lon: 2.3
    },
    {
      city: "Barcelona"
    })}

    it 'searches rooms with correct query' do
      results = double('Elastic Search results', results: ["ROOM1", "ROOM2"])
      expect(Room).to receive(:search).with(query:
      {
        bool: {
          must: [
          {
            geo_bounding_box: {
              location: {
                top_left: {
                  lat: 41.5,
                  lon: 2.0
                },
                bottom_right: {
                  lat: 41.3,
                  lon: 2.3
                }
              }
            }
          },
          { match: { 'city.name': "Barcelona" }}
          ]
        }
      }).and_return(results)

      expect(ObjectService::Success).to receive(:new)

      search_room_service.call
    end
  end

  context 'when it finds rooms' do
    let(:search_room_service) { SearchRoomsService.new(
      {
        top_left_lat: 41.5,
        top_left_lon: 2.0
      },
      {
        bottom_right_lat: 41.3,
        bottom_right_lon: 2.3
      },
      {
        city: "Barcelona",
        page: 10,
        size: 2
      })}
    it 'returns a success object' do
      results = double('Elastic Search results', results: ["ROOM1", "ROOM2"])
      expect(Room).to receive(:search).and_return(results)
      expect(ObjectService::Success).to receive(:new)
      search_room_service.call
    end
  end

  context 'when it does not find rooms' do
    let(:search_room_service) { SearchRoomsService.new(
      {
        top_left_lat: 41.5,
        top_left_lon: 2.0
      },
      {
        bottom_right_lat: 41.3,
        bottom_right_lon: 2.3
      },
      {
        city: "Barcelona",
        page: 10,
        size: 2
      })}
    it 'returns an error object' do
      results = double('Elastic Search results', results: [])
      expect(Room).to receive(:search).and_return(results)
      expect(ObjectService::Error).to receive(:new)
      search_room_service.call
    end
  end
end
