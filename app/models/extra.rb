class Extra < ApplicationRecord
  has_and_belongs_to_many :rooms
  validates :name, presence: true, length: { minimum: 2, maximum: 160 }, uniqueness: true
end
