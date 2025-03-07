class AddConfirmedToEbook < ActiveRecord::Migration[8.0]
  def change
    add_column :ebooks, :confirmed, :boolean, default: false
  end
end
