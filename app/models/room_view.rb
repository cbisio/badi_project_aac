class RoomView < ApplicationRecord
  belongs_to :room

  validates :ip, length: { minimum: 7, maximum: 15}, presence: true



  def update_counter()
    @room = Room.find(self.room_id)
    if(self.updated_at < Time.now - 86400)
      self.update_attribute(:updated_at, Time.now)
      @room.update_attribute(:num_visits, @room.num_visits + 1)
    elsif (self.updated_at > Time.now - 5)
      @room.update_attribute(:num_visits, @room.num_visits + 1)
    end
  end


end
