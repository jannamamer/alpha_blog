# frozen_string_literal: true

class CreateLookUps < ActiveRecord::Migration[6.0]
  def change
    create_table :look_ups do |t|
      t.string :type, null: false
      t.string :name, null: false
    end
  end
end
