require 'rails_helper'

describe 'GET /search/:text', type: :request do
  before {get '/api/badi/v1/search/Barcelona'}
  it 'returns a 200 status code' do
    expect(response).to have_http_status(200)
  end

  it "should return data" do
    payload = JSON.parse(response.body)
    expect(payload).to be_empty  
  end

end
