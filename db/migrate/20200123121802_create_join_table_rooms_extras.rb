# frozen_string_literal: true

class CreateJoinTableRoomsExtras < ActiveRecord::Migration[6.0]
  def change
    create_join_table :rooms, :extras do |t|
      t.index %i[room_id extra_id]
      t.index %i[extra_id room_id]
    end
  end
end
