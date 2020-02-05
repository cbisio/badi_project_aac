# frozen_string_literal: true

require 'rails_helper'

describe 'GET /health', type: :request do
  it 'returns a 200 status code' do
    get '/health'

    expect(response).to have_http_status(200)
  end
end
