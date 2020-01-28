module Badi
  module V1
    class Search < Grape::API
      params do
        requires :text, type: String, desc: 'Should have a text query param'
      end
      desc 'Returns the search of the service'
      get '/search' do
        # Send response
        status :ok
        GeocodingService.call(params[:text])
      end
    end
  end
end
