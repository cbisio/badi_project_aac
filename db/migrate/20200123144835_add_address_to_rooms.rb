# frozen_string_literal: true

class AddAddressToRooms < ActiveRecord::Migration[6.0]
  def change
    add_column :rooms, :address, :string
  end
end
