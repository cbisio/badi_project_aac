module Badi
  module V1
    class Search < Grape::API
      params do
        requires :text, type: String, message: I18n.t('api.search.errors.text_param_required')
        optional :limit, type: Integer
      end
      desc 'Returns the search of the service'
      get '/search' do
        # Optional query params
        opts = {}
        opts[:limit] = params[:limit] if params[:limit]

        result = GeocodingService.call(params[:text], opts)

        if result.success?
          status :ok
          result.data
        else
          raise Badi::V1::ExceptionHandler::GeocodingServiceError.new(result.error_code), result.error_message
        end
      end
    end
  end
end
