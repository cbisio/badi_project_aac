module Badi
  module V1
    module ExceptionHandler
      extend ActiveSupport::Concern

      included do
        rescue_from ActiveRecord::RecordInvalid do |e|
          error!(e.message, 422)
        end
      end

    end
  end
end
