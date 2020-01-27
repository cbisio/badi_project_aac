class City < ApplicationRecord
  has_many :rooms
  validates :name, length: { minimum: 3, maximum: 80 }, presence: true
end
