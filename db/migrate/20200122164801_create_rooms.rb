class CreateRooms < ActiveRecord::Migration[6.0]
  def change
    create_table :rooms do |t|
      t.string :name
      t.integer :price
      t.boolean :bills_included
      t.integer :deposit
      t.integer :room_size
      t.integer :property_size
      t.text :description
      t.float :latitude, :limit => 30
      t.float :longitude, :limit => 30
      t.integer :num_visits
      
      t.timestamps
    end
  end
end
