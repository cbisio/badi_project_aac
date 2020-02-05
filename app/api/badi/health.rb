# frozen_string_literal: true

module Badi
  # Health Class
  class Health < Grape::API
    desc 'Returns the health of the service'
    get '/health' do
      status :ok
    end
  end
end
