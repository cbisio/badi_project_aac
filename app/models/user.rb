class User < ApplicationRecord
  has_many :rooms
  validates :gender, :birth_date, presence: true
  validates_inclusion_of :gender, in: [['Male'], ['Female'], ['Other']]
  validates :name, length: { minimum: 5, maximum: 80 }, presence: true
  validates :about, length: { minimum: 5, maximum: 200 }, presence: true
end
