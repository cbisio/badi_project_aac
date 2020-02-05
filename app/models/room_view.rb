# frozen_string_literal: true

class RoomView < ApplicationRecord
  belongs_to :room

  validates :ip, length: { minimum: 7, maximum: 15 }, presence: true
end
