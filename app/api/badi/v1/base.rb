module Badi
  module V1
    class Base < Grape::API
      version 'V1', using: :path
      include Badi::V1::ExceptionHandler
      # TODO: Mount classes to respond to api calls
    end
  end
end
