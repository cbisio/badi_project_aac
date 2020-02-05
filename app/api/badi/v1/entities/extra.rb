# frozen_string_literal: true

module Badi
  module V1
    module Entities
      # Extra entity
      class Extra < Grape::Entity
        expose :id
        expose :name
      end
    end
  end
end
