class Room < ApplicationRecord
  belongs_to :user
  validates :name, :price, :description, :latitude, :longitude, presence: true
end
