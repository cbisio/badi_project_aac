class Photo < ApplicationRecord
  belongs_to :room
  validates :url, :order, presence: true
end
