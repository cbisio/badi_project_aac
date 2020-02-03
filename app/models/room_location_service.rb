class RoomLocationService < ApplicationRecord
  belongs_to :room

  validates :health, :leisure, :transport, :food, :tourism, presence: true, :numericality => { :greater_than_or_equal_to => 0}
end
