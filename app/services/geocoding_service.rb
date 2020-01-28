class GeocodingService
  attr_reader :text

  def self.call(*args)
    new(*args).call
  end

  def initialize(text, opts = {})
    @text = text
    @countries = opts[:countries] || 'ES'
    @limit = opts[:limit] || 10
    @search_types = opts[:search_types] || 'Geo,PAD,Addr,Str'
    @language = opts[:language] || 'en-US'
    @predictive_mode = opts[:predictive_mode] || true
  end

  def call
    response = request_geocoding_third_api_service

    raise Badi::V1::ExceptionHandler::GeocodingServiceError 'There was en error accessing to geocoding service' unless response.code == 200

    json = JSON.parse(response.body)

    # Return cleaned locations
    clean_locations_response(json)
  end

  private

  def request_geocoding_third_api_service
    query = {
      key: ENV['TOMTOM_API_KEY'],
      countrySet: @countries,
      limit: @search_limit,
      language: @language,
      idxSet: @search_types,
      typeahead: @predictive_mode
    }

    HTTParty.get(url, query: query)
  end

  def url
    "https://api.tomtom.com/search/2/search/#{@text}.json"
  end

  def clean_locations_response(dirty_locations)
    locations = []
    dirty_locations['results'].map { |result|
      result_higher_than_city?(result) ? city = nil : city = result['address']['municipality']
      locations.push(
        {
          name: result['address']['freeformAddress'],
          city: city,
          bbox: {
            topLeftPoint: {
              lat: result['viewport']['topLeftPoint']['lat'],
              lon: result['viewport']['topLeftPoint']['lon']
            },
            btmRightPoint: {
              lat: result['viewport']['btmRightPoint']['lat'],
              lon: result['viewport']['btmRightPoint']['lon']
            }
          }
        }
      )
    }
    {
      locations: locations
    }
  end

  def result_higher_than_city?(result)
    is_higher = false
    if result['type'] == 'Geography'
      if result['entityType'] == 'Country' || result['entityType'] == 'CountrySubdivision' || result['entityType'] == 'CountrySecondarySubdivision' || result['entityType'] == 'CountryTertiarySubdivision'
        is_higher = true
      end
    end
    is_higher
  end
end
