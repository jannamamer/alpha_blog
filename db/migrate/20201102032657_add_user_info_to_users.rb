# frozen_string_literal: true

class AddUserInfoToUsers < ActiveRecord::Migration[6.0]
  def change
    change_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.integer :gender
    end
  end
end
