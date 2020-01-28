module Badi
  module V1
    module ExceptionHandler
      extend ActiveSupport::Concern

      class GeocodingServiceError < StandardError; end

      included do
        rescue_from Badi::V1::ExceptionHandler::GeocodingServiceError do |e|
          error!(e.message, 424)
        end

        rescue_from Grape::Exceptions::ValidationErrors do |e|
          error!(e.message, 422)
        end
      end
    end
  end
end
