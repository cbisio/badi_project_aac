module Badi
  class API < Grape::API
    format :json
    content_type :json, 'application/json; charset=utf-8'

    mount Badi::Health
    # mount Badi::APIv1
  end
end
