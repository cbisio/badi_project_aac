class CreateJoinTableRoomsExtras < ActiveRecord::Migration[6.0]
  def change
    create_join_table :rooms, :extras do |t|
       t.index [:room_id, :extra_id]
       t.index [:extra_id, :room_id]
    end
  end
end
