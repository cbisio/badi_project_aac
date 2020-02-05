# frozen_string_literal: true

# Extra model
class Extra < ApplicationRecord
  has_and_belongs_to_many :rooms

  validates :name, length: { minimum: 2, maximum: 160 }, uniqueness: true, presence: true
end
