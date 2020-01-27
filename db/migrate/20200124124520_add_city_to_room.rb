class AddCityToRoom < ActiveRecord::Migration[6.0]
  def change
    add_reference :rooms, :city, null: false, foreign_key: true
  end
end
