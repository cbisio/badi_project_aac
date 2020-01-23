class Room < ApplicationRecord
  belongs_to :user
  has_many :photos
  has_and_belongs_to_many :extras
  validates :name, :price, :description, :latitude, :longitude, presence: true
end
