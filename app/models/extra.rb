class Extra < ApplicationRecord
  has_and_belongs_to_many :rooms
  validates :name, presence: true, length: { minimum: 3, maximum: 160 }
end
