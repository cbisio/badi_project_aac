# frozen_string_literal: true

module Badi
  module V1
    module Entities
      # RoomLocationService entity
      class RoomLocationService < Grape::Entity
        expose :id
        expose :health
        expose :leisure
        expose :transport
        expose :food
        expose :tourism
      end
    end
  end
end
