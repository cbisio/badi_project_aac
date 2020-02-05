# frozen_string_literal: true

module Badi
  module V1
    module Entities
      # Rooms entity
      class Rooms < Grape::Entity
        expose :rooms, using: Badi::V1::Entities::Room
      end
    end
  end
end
