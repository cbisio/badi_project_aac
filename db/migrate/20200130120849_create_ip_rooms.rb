class CreateIpRooms < ActiveRecord::Migration[6.0]
  def change
    create_table :ip_rooms do |t|
      t.string :ip
      t.references :room, null: false, foreign_key: true

      t.timestamps
    end
  end
end
