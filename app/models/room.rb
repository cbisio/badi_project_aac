require 'elasticsearch/model'

class Room < ApplicationRecord
  # Elastic Search
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  settings do
    mappings dynamic: false do
      indexes :location, type: :geo_point
      indexes :city, type: :object do
        indexes :name
      end
      indexes :room_location_service, type: :object do
        indexes :health, type: :integer
        indexes :leisure, type: :integer
        indexes :transport, type: :integer
        indexes :food, type: :integer
        indexes :tourism, type: :integer
      end
    end
  end

  # Customize the JSON serialization for Elasticsearch
  def as_indexed_json(options={})
    as_json(include: {
      city: { only: :name },
      room_location_service: { only: [:health, :leisure, :transport, :food, :tourism] }
    }).merge location: { lat: latitude, lon: longitude }
  end

  # Associations
  belongs_to :owner, class_name: "User", foreign_key: "user_id"
  belongs_to :city
  has_many :photos
  has_and_belongs_to_many :extras
  has_one :room_location_service
  has_many :room_views

  # Validations
  validates :name, length: { minimum: 5, maximum: 80}, presence: true
  validates :address, length: { minimum: 10, maximum: 200}, presence: true
  validates :price, :numericality => { :greater_than => 10, :less_than => 10000}, presence: true
  validates :latitude, :numericality => { :greater_than => -90, :less_than => 90}, presence: true
  validates :longitude, :numericality => { :greater_than => -180, :less_than => 180}, presence: true
  validates :currency, :inclusion => {:in => ['€', '$']}, presence: true
end


