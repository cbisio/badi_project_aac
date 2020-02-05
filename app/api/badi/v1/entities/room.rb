# frozen_string_literal: true

module Badi
  module V1
    module Entities
      # Room entity
      class Room < Grape::Entity
        expose :id
        expose :name
        expose :price
        expose :bills_included
        expose :deposit
        expose :room_size
        expose :property_size
        expose :description
        expose :latitude
        expose :longitude
        expose :num_visits
        expose :created_at
        expose :updated_at
        expose :owner, using: Badi::V1::Entities::User
        expose :address
        expose :city, using: Badi::V1::Entities::City
        expose :currency
        expose :extras, using: Badi::V1::Entities::Extra
        expose :photos, using: Badi::V1::Entities::Photo
        expose :room_location_service, using: Badi::V1::Entities::RoomLocationService
      end
    end
  end
end
