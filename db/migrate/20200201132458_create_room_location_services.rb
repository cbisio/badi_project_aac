# frozen_string_literal: true

class CreateRoomLocationServices < ActiveRecord::Migration[6.0]
  def change
    create_table :room_location_services do |t|
      t.integer :health
      t.integer :leisure
      t.integer :transport
      t.integer :food
      t.integer :tourism
      t.references :room, null: false, foreign_key: true

      t.timestamps
    end
  end
end
