class Photo < ApplicationRecord
  belongs_to :room
  has_one_attached :url
  #validates :url, presence: true, length: { minimum: 5, maximum: 80 }
  validates :order, presence: true
  validates_numericality_of :order, greater_than: 0
end
