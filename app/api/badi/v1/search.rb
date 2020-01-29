module Badi
  module V1
    class Search < Grape::API
      params do
        requires :text, type: String, desc: 'Should have a text query param'
      end
      desc 'Returns the search of the service'
      get '/search' do
        result = GeocodingService.call(params[:text])
        if result.success?
          status :ok
          result.data
        else
          raise Badi::V1::ExceptionHandler::GeocodingServiceError, result.error
        end
      end
    end
  end
end
