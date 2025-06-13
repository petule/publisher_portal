class AddStateToEbook < ActiveRecord::Migration[8.0]
  def change
    add_column :ebooks, :state, :integer, default: 0
  end
end
