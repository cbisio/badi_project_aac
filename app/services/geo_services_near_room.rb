# frozen_string_literal: true

# Locate services near a room
class GeoServicesNearRoom
  attr_reader :text

  def self.call(*args)
    new(*args).call
  end

  def initialize(id_room, _opts = {})
    @countries = 'ES'
    @language = 'en-US'

    unless (@rls = RoomLocationService.find_by('room_id = ?', id_room))
      @rls = RoomLocationService.new
      @rls.room_id = id_room
    end

    @room = Room.find(id_room)
  end

  def call
    @rls.health = calculate('Doctor', 100) + calculate('Hospital', 250) + calculate('Pharmacy', 100)
    @rls.leisure = calculate('Nightlife', 200) + calculate('Cinema', 200) + calculate('Sport', 100)
    @rls.transport = calculate('Bus', 100) + calculate('Subway', 200) + calculate('Train', 300)
    @rls.food = calculate('Restaurant', 200) + calculate('Supermarket', 100)
    @rls.tourism = calculate('Tourism', 250)

    @rls.save!
  end

  def calculate(text, distance)
    @text = text
    @distance_m = distance

    response = request_geocoding_near

    if response.code == 200
      json = JSON.parse(response.body)
      json['summary']['totalResults']
    else
      0
    end
  end

  private

  def request_geocoding_near
    query = {
      key: ENV['TOMTOM_API_KEY'],
      countrySet: 'ES',
      lat: @room.latitude,
      lon: @room.longitude,
      radius: @distance_m,
      limit: 100
    }

    HTTParty.get(url, query: query)
  end

  def url
    "https://api.tomtom.com/search/2/poiSearch/#{@text}.json"
  end
end
