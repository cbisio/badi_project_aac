class Room < ApplicationRecord
  belongs_to :user
  has_many :photos
  has_and_belongs_to_many :extras
  validates :description, :latitude, :longitude,  presence: true
  validates :name,  presence: true, length: { minimum: 3, maximum: 15 }
  validates :address,  presence: true, length: { minimum: 10, maximum: 100 }
  validates :price, presence: true, :numericality => { :greater_than => 10, :less_than => 1000 }
end
