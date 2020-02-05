# frozen_string_literal: true

class CreateRoomViews < ActiveRecord::Migration[6.0]
  def change
    create_table :room_views do |t|
      t.string :ip
      t.references :room, null: false, foreign_key: true

      t.timestamps
    end
  end
end
