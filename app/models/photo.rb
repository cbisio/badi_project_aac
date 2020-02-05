# frozen_string_literal: true

# Photo model
class Photo < ApplicationRecord
  belongs_to :room

  validates :url, length: { minimum: 5, maximum: 120 }, presence: true
  validates :order, presence: true
  validates_numericality_of :order, greater_than: 0
end
