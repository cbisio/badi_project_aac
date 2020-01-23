class Photo < ApplicationRecord
  belongs_to :room
  validates :url, presence: true, length: { minimum: 5, maximum: 160 }
  validates :order, presence: true
  validates_numericality_of :order, greater_than_or_equal_to: 1
end
