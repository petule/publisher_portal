class CreateEbookCategory < ActiveRecord::Migration[8.0]
  def change
    create_table :ebook_categories do |t|
      t.references :ebook, index: true
      t.references :category, index: true

      t.timestamps
    end
  end
end
