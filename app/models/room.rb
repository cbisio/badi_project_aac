class Room < ApplicationRecord
  belongs_to :user
  belongs_to :city
  has_many :photos
  has_and_belongs_to_many :extras
  has_one :room_location_service

  validates :name, length: { minimum: 5, maximum: 80}, presence: true
  validates :address, length: { minimum: 10, maximum: 200}, presence: true
  validates :price, :numericality => { :greater_than => 10, :less_than => 10000}, presence: true
  validates :latitude, :numericality => { :greater_than => -90, :less_than => 90}, presence: true
  validates :longitude, :numericality => { :greater_than => -180, :less_than => 180}, presence: true
  validates :currency, :inclusion => {:in => ['€', '$']}, presence: true

end
