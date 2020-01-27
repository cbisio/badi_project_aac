module Badi
  module V1
    class Search < Grape::API
      version 'V1', using: :path
      desc 'Returns the search of the service'
      get '/search/:text' do

        query = {
          access_token: ENV['MAPBOX_API_KEY'],
          country: 'es',
          limit: 10,
          types: 'country,region,postcode,district,place,locality,neighborhood,address'
        }

        response = HTTParty.get(
          "https://api.mapbox.com/geocoding/v5/mapbox.places/#{params[:text]}.json",
          query: query
        )

        status :ok
        JSON.parse(response.body)


      end
    end
  end
end
