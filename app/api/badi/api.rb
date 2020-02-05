# frozen_string_literal: true

module Badi
  class API < Grape::API
    format :json
    content_type :json, 'application/json; charset=utf-8'

    mount Badi::Health
    mount Badi::V1::Base
  end
end
