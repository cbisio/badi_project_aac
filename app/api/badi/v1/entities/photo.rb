# frozen_string_literal: true

module Badi
  module V1
    module Entities
      # Photo entity
      class Photo < Grape::Entity
        expose :id
        expose :url
        expose :order
      end
    end
  end
end
