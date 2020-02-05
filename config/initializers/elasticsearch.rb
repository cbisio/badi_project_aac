# frozen_string_literal: true

config = {
  host: ENV['BONSAI_URL'],
  transport_options: {
    request: { timeout: 5 }
  }
}

config.merge!(YAML.load_file('config/elasticsearch.yml')[Rails.env].deep_symbolize_keys) if File.exist?('config/elasticsearch.yml')

Elasticsearch::Model.client = Elasticsearch::Client.new(config)
