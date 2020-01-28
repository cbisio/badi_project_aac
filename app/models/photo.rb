class Photo < ApplicationRecord
  belongs_to :room
  validates :url, presence: true, length: { minimum: 5, maximum: 120 }
  validates :order, presence: true
  validates_numericality_of :order, greater_than: 0
end
