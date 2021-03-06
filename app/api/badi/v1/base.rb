# frozen_string_literal: true

module Badi
  module V1
    # Base Grape API Class
    class Base < Grape::API
      version 'V1', using: :path
      include Badi::V1::ExceptionHandler

      mount Badi::V1::Search
      mount Badi::V1::Rooms
    end
  end
end
