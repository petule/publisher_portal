class CreateEbooks < ActiveRecord::Migration[8.0]
  def change
    create_table :ebooks do |t|
      t.string :title
      t.string :original_title
      t.string :subtitle
      t.string :short_content
      t.text :content
      t.text :anotation
      t.string :video
      t.string :isbn
      t.string :isbn_epub
      t.string :isbn_mobi
      t.string :isbn_pdf
      t.references :series, null: false, foreign_key: true
      t.integer :percentage_preview
      t.references :language, null: false, foreign_key: true
      t.datetime :activate_at
      t.datetime :change_at
      t.boolean :active
      t.string :internal_number
      t.references :publisher, null: false, foreign_key: true
      t.integer :part
      t.integer :publication_year
      t.integer :page_count
      t.integer :publication_place
      t.datetime :licence_end_at
      t.datetime :sale_start_at
      t.datetime :sale_end_at
      t.string :url
      t.boolean :sponsored

      t.timestamps
    end
  end
end
