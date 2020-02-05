# frozen_string_literal: true

module Badi
  module V1
    module Entities
      # User entity
      class User < Grape::Entity
        expose :id
        expose :name
        expose :birth_date
        expose :gender
        expose :about
      end
    end
  end
end
