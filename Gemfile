source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.5'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.0.2', '>= 6.0.2.1'
# Use postgres as the database for Active Record
gem 'pg', '>= 1.2.2'
# Use Puma as the app server
gem 'puma', '~> 4.1'
# Use Grape as the framework for creating REST-like APIs
gem 'grape'
gem 'grape-entity'
gem 'grape_on_rails_routes'
# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.2', require: false

# Sharing configuration variables across environments
gem 'dotenv-rails', groups: [:development, :test]

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
# gem 'rack-cors'

group :development, :test do
  # Use Rspec to support Rspec examples for requests, controllers, models, etc
  gem 'rspec-rails', '~> 3.9'
  # Use Pry to debug
  gem 'pry-rails'
  # Enforces Rails best practices and coding conventions.
  gem 'rubocop-rails', require: false
end

group :test do
  gem 'factory_bot_rails'
  gem 'shoulda-matchers'
  gem 'faker'
  gem 'database_cleaner'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  # Use SimpleCov to analyze the code coverage
  gem 'simplecov', require: false
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

# HTTParty gem to create requests
gem 'httparty'