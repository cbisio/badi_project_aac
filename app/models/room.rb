class Room < ApplicationRecord
  belongs_to :user
  has_many :photos
  has_and_belongs_to_many :extras
  validates :name, presence: true, length: { minimum: 3, maximum: 15 }
  validates :address, presence: true, length: { minimum: 10, maximum: 100 }
  validates :description, presence: true, length: { minimum: 10, maximum: 200 }
  validates :price, presence: true, :numericality => { :greater_than => 10, :less_than => 1000 }
  validates :latitude, presence: true, :numericality => { :greater_than => -90, :less_than => 90 }
  validates :longitude, presence: true, :numericality => { :greater_than => -180, :less_than => 180 }
end
