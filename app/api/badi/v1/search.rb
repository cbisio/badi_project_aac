module Badi
  module V1
    class Search < Grape::API
      version 'V1', using: :path
        desc 'Returns the search of the service'
        get '/search/text' do

          query = {
            "access_token"     => "pk.eyJ1IjoiY2FtaWxhbWVqb3IiLCJhIjoiY2s1cW5hZzRoMDN2dDNvcDJkdTNxcWtvdSJ9.EmlMXuzEQ7t9QL7J7eab4A",
            "country"     => "es",
            "limit"     => 10,
            "types"     => "country,region,postcode,district,place,locality,neighborhood,address"
          }


          response = HTTParty.post(
            "https://api.mapbox.com/geocoding/v5/mapbox.places/#{params[:text]}.json",
            :query => query
          )

          JSON.parse(response.body)
          status :ok

        end
    end
  end
end
