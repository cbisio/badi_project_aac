module Badi
  module V1
    module Entities
      class RoomSimple < Grape::Entity
        expose :id
        expose :name
        expose :price
        expose :bills_included
        expose :deposit
        expose :latitude
        expose :longitude
        expose :num_visits
        expose :created_at
        expose :updated_at
        expose :user
        expose :address
        expose :city
        expose :currency
      end
    end
  end
end
