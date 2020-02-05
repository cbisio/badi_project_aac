# frozen_string_literal: true

# Default superclass of all models
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end
