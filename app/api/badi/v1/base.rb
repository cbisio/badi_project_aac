module Badi
  module V1
    class Base < Grape::API
      version 'V1', using: :path
      include Badi::V1::ExceptionHandler

      mount Badi::V1::Search
      mount Badi::V1::Rooms
    end
  end
end
