# frozen_string_literal: true

class RemoveImageGenderFromUsers < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :image
    remove_column :users, :gender
  end
end
