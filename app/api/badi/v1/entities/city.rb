# frozen_string_literal: true

module Badi
  module V1
    module Entities
      # City entity
      class City < Grape::Entity
        expose :id
        expose :name
      end
    end
  end
end
