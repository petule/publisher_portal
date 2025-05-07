class AddImportToSeriesAndEbook < ActiveRecord::Migration[8.0]
  def change
    add_column :ebooks, :imported, :boolean, default: false
    add_column :series, :imported, :boolean, default: false
    add_column :ebooks, :last_import_at, :timestamp
    add_column :series, :last_import_at, :timestamp
  end
end
