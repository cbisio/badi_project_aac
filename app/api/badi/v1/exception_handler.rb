# frozen_string_literal: true

module Badi
  module V1
    # ExceptionHandler Grape API Class
    module ExceptionHandler
      extend ActiveSupport::Concern
      # Customized Error Class RoomNotFound
      class RoomNotFound < StandardError; end
      # Customized Error Class GeocodingServiceError
      class GeocodingServiceError < StandardError
        attr_reader :status_code
        def initialize(status_code)
          @status_code = status_code
        end
      end
      # Customized Error Class SearchRoomsServiceError
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
