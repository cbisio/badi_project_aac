# frozen_string_literal: true

module Badi
  module V1
    # Search Grape API Class
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

        raise Badi::V1::ExceptionHandler::GeocodingServiceError.new(result.error_code), result.error_message unless result.success?

        status :ok
        result.data
      end
    end
  end
end
