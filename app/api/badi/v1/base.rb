module Badi
  module V1
    class Base < Grape::API
      version 'V1', using: :path
      # TODO: Mount classes to respond to api calls
      mount Badi::V1::Rooms
    end
  end
end
