# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :name
      t.date :birth
      t.string :gender
      t.text :about

      t.timestamps
    end
  end
end
