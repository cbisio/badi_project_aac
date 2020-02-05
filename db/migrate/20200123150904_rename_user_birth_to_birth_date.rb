# frozen_string_literal: true

class RenameUserBirthToBirthDate < ActiveRecord::Migration[6.0]
  def change
    rename_column :users, :birth, :birth_date
  end
end
