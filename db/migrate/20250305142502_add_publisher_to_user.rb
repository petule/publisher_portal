class AddPublisherToUser < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :publisher_id, :integer
    add_index :users, :publisher_id
  end
end
