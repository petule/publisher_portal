class ChangeIsbnInSeries < ActiveRecord::Migration[8.0]
  def change
    remove_column :series, :isbn_epub
    remove_column :series, :isbn_mobi
    remove_column :series, :isbn_pdf
    add_column :series, :isbn, :string
  end
end
