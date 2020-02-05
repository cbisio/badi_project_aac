# frozen_string_literal: true

# City model
class City < ApplicationRecord
  has_many :rooms

  validates :name, length: { minimum: 3, maximum: 80 }, uniqueness: true, presence: true
end
