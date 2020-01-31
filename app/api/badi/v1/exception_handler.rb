module Badi
  module V1
    module ExceptionHandler
      extend ActiveSupport::Concern

      class RoomNotFound < StandardError; end
      class GeocodingServiceError < StandardError
        attr_reader :status_code
        def initialize(status_code)
          @status_code = status_code
        end
      end
      class SearchRoomsServiceError < StandardError
        attr_reader :status_code
        def initialize(status_code)
          @status_code = status_code
        end
      end

      included do

        rescue_from Grape::Exceptions::ValidationErrors do |e|
          error!(e.message, 422)
        end

        rescue_from Badi::V1::ExceptionHandler::RoomNotFound do |e|
          error!(e.message, 404)
        end

        rescue_from ActiveRecord::RecordInvalid do |e|
          error!(e.message, 422)
        end

        rescue_from Badi::V1::ExceptionHandler::GeocodingServiceError do |e|
          error!(e.message, e.status_code)
        end

        rescue_from Badi::V1::ExceptionHandler::SearchRoomsServiceError do |e|
          error!(e.message, e.status_code)
        end
      end
    end
  end
end
