class User < ApplicationRecord
  has_many :rooms
  validates :gender, :birth_date, presence: true
  validates :gender, :inclusion => {:in => ['Male', 'Female', 'Other']}
  validates :name, length: { minimum: 3, maximum: 80 }, presence: true
end
