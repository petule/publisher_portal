class CreateEbookAuthors < ActiveRecord::Migration[8.0]
  def change
    create_table :ebook_authors do |t|
      t.references :ebook, null: false, foreign_key: true
      t.references :author, null: false, foreign_key: true

      t.timestamps
    end
  end
end
