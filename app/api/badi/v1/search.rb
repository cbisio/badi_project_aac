module Badi
  module V1
    class Search < Grape::API
      params do
        requires :text, type: String, message: I18n.t('api.search.errors.text_param_required')
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
