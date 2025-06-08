class AddPositionToCategory < ActiveRecord::Migration[8.0]
  def change
    add_column :categories, :position, :integer, default: 1
  end
end
