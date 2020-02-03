module Badi
  module V1
    module Entities
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
        expose :user
        expose :address
        expose :city
        expose :currency
        expose :extras
        expose :photos
        expose :room_location_service
      end
    end
  end
end
