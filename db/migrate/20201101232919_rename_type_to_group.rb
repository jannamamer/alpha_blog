# frozen_string_literal: true

class RenameTypeToGroup < ActiveRecord::Migration[6.0]
  def change
    rename_column :look_ups, :type, :group
  end
end
