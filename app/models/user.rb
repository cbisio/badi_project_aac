# frozen_string_literal: true

# User model
class User < ApplicationRecord
  has_many :rooms

  validates :birth_date, presence: true
  validates :gender, inclusion: { in: %w[Male Female Other] }, presence: true
  validates :name, length: { minimum: 3, maximum: 80 }, presence: true
end
