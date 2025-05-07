class AddCheckedToSeriesAndEbook < ActiveRecord::Migration[8.0]
  def change
    add_column :ebooks, :checked, :boolean, default: false
    add_column :series, :checked, :boolean, default: false
  end
end
