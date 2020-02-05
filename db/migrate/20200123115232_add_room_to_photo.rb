# frozen_string_literal: true

class AddRoomToPhoto < ActiveRecord::Migration[6.0]
  def change
    add_reference :photos, :room, null: false, foreign_key: true
  end
end
