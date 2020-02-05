# frozen_string_literal: true

class CreateExtras < ActiveRecord::Migration[6.0]
  def change
    create_table :extras do |t|
      t.string :name

      t.timestamps
    end
  end
end
