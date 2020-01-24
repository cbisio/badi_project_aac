module Badi
  module V1
    class Base < Grape::API
      version 'V1', using: :path
      # TODO: Mount classes to respond to api calls
    end
  end
end
