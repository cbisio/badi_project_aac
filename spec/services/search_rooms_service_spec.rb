# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SearchRoomsService do
  let(:top_left_point) do
    {
      top_left_lat: 41.5,
      top_left_lon: 2.0
    }
  end

  let(:bottom_right_point) do
    {
      bottom_right_lat: 41.3,
      bottom_right_lon: 2.3
    }
  end

  let(:opts_empty) do
    {

    }
  end

  let(:opts_with_pagination) do
    {
      city: 'Barcelona',
      page: 10,
      size: 2
    }
  end

  let(:opts_without_pagination) do
    {
      city: 'Barcelona'
    }
  end

  let(:opts_wit_sort_by) do
    {
      city: 'Barcelona',
      sort_by: 'food'
    }
  end

  context 'when there is pagination' do
    it 'searches rooms with correct query' do
      results = double('Elastic Search results', results: ['Room1', 'Room 2'])
      expect(Room).to receive(:search).with(
        query: {
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
              { match: { 'city.name': 'Barcelona' } }
            ]
          }
        },
        sort: [],
        from: 10,
        size: 2
      ).and_return(results)

      expect(ObjectService::Success).to receive(:new)

      SearchRoomsService.call(top_left_point, bottom_right_point, opts_with_pagination)
    end
  end

  context 'when there is no pagination' do
    it 'searches rooms with correct query' do
      results = double('Elastic Search results', results: %w[ROOM1 ROOM2])
      expect(Room).to receive(:search).with(
        query: {
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
              { match: { 'city.name': 'Barcelona' } }
            ]
          }
        },
        sort: []
      ).and_return(results)

      expect(ObjectService::Success).to receive(:new)

      SearchRoomsService.call(top_left_point, bottom_right_point, opts_without_pagination)
    end
  end

  context 'when sort_by has been specified' do
    it 'searches with the correct query' do
      results = double('Elastic Search results', results: %w[ROOM1 ROOM2])
      expect(Room).to receive(:search).with(
        query: {
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
              { match: { 'city.name': 'Barcelona' } }
            ]
          }
        },
        sort: [{ 'room_location_service.food': { order: 'desc' } }]
      ).and_return(results)

      SearchRoomsService.call(top_left_point, bottom_right_point, opts_wit_sort_by)
    end
  end

  context 'when it finds rooms' do
    it 'returns a success object' do
      results = double('Elastic Search results', results: %w[ROOM1 ROOM2])
      expect(Room).to receive(:search).and_return(results)
      expect(ObjectService::Success).to receive(:new)
      SearchRoomsService.call(top_left_point, bottom_right_point, opts_with_pagination)
    end
  end

  context 'when it does not find rooms' do
    it 'returns an error object' do
      results = double('Elastic Search results', results: [])
      expect(Room).to receive(:search).and_return(results)
      expect(ObjectService::Error).to receive(:new)
      SearchRoomsService.call(top_left_point, bottom_right_point, opts_with_pagination)
    end
  end

  context 'when no city name is provided' do
    it 'searches rooms with correct query' do
      results = double('Elastic Search results', results: ['Room1', 'Room 2'])
      expect(Room).to receive(:search).with(
        query: {
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
              }
            ]
          }
        },
        sort: []
      ).and_return(results)

      expect(ObjectService::Success).to receive(:new)

      SearchRoomsService.call(top_left_point, bottom_right_point, opts_empty)
    end
  end
end
