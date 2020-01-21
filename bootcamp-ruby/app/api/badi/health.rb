module Badi
  class Health < Grape::API
    desc 'Returns the health of the service'
    get '/health' do
      status :ok
    end
  end
end
