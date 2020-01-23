class User < ApplicationRecord
  has_many :rooms
  validates :name, :birth, :gender, presence: true
  validates :name, length: { minimum: 5, maximum: 80 }
end
